// lib/mobile/screens/favorite_screen.dart
// OPTIMIZED WITH REPAINTBOUNDARY FOR SMOOTH SCROLLING

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../database/database_helper.dart';
import '../mobile_app.dart';
import 'player_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> _favorites = [];
  bool _isLoading = true;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final data = await DatabaseHelper().getFavorites();
    if (mounted) {
      setState(() {
        _favorites = data;
        _isLoading = false;
      });
    }
  }

  Future<void> _removeFavorite(String dramaId, String dramaTitle) async {
    setState(() => _isDeleting = true);
    await DatabaseHelper().removeFromFavorites(dramaId);
    await _loadFavorites();
    if (mounted) {
      setState(() => _isDeleting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$dramaTitle dihapus dari favorit"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _confirmRemove(String dramaId, String dramaTitle) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text('Hapus dari Favorit', style: TextStyle(color: Colors.white)),
        content: Text('Yakin ingin menghapus "$dramaTitle" dari favorit?',
            style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('BATAL', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _removeFavorite(dramaId, dramaTitle);
            },
            child: const Text('HAPUS', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("FAVORIT", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF161B22),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_favorites.isNotEmpty)
            TextButton(
              onPressed: () => _confirmRemoveAll(),
              child: const Text('HAPUS SEMUA', style: TextStyle(color: Colors.red, fontSize: 12)),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF06B6D4)))
          : _favorites.isEmpty
              ? RepaintBoundary(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.favorite_border, color: Colors.white24, size: 64),
                        const SizedBox(height: 16),
                        const Text('Belum ada favorit',
                            style: TextStyle(color: Colors.white38)),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cari Drama', style: TextStyle(color: Color(0xFF06B6D4))),
                        ),
                      ],
                    ),
                  ),
                )
              : RepaintBoundary(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _favorites.length,
                    itemBuilder: (_, i) {
                      final item = _favorites[i];
                      return RepaintBoundary(
                        key: ValueKey('favorite_${item['drama_id']}_$i'),
                        child: _OptimizedFavoriteCard(
                          item: item,
                          onTap: () {
                            context.navigateToPlayer(
                              id: item['drama_id'].toString(),
                              source: item['platform'],
                              title: item['drama_title'],
                            );
                          },
                          onRemove: () => _confirmRemove(
                            item['drama_id'].toString(),
                            item['drama_title'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  void _confirmRemoveAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text('Hapus Semua Favorit', style: TextStyle(color: Colors.white)),
        content: const Text('Yakin ingin menghapus semua favorit?',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('BATAL', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() => _isDeleting = true);
              for (var item in _favorites) {
                await DatabaseHelper().removeFromFavorites(item['drama_id'].toString());
              }
              await _loadFavorites();
              if (mounted) {
                setState(() => _isDeleting = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Semua favorit dihapus'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('HAPUS SEMUA', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// OPTIMIZED FAVORITE CARD - Separate widget
// ============================================================
class _OptimizedFavoriteCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _OptimizedFavoriteCard({
    required this.item,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Poster image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: item['drama_poster'] ?? '',
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: const Color(0xFF1A2232)),
              errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A2232)),
            ),
          ),
          
          // Gradient overlay bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Platform badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF06B6D4).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      item['platform']?.toString().toUpperCase() ?? '',
                      style: const TextStyle(
                        color: Color(0xFF06B6D4),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Title
                  Text(
                    item['drama_title'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          
          // Heart icon (favorite indicator)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.favorite, color: Colors.red, size: 12),
            ),
          ),
          
          // Delete button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.5), width: 0.5),
                ),
                child: const Icon(Icons.delete_outline, color: Colors.red, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
