// lib/mobile/screens/search_screen.dart
// OPTIMIZED WITH REPAINTBOUNDARY FOR SMOOTH SCROLLING

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/drama_repository.dart';
import '../../utils/mapping.dart';
import '../mobile_app.dart';
import 'player_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  List<dynamic> _results = [];
  bool _isLoading = false;
  String _selectedPlatform = "freereels";
  String _selectedPlatformName = "FreeReels";
  
  late final List<Map<String, String>> _platforms;

  @override
  void initState() {
    super.initState();
    _platforms = AppMapping.searchablePlatforms;
    if (_platforms.isNotEmpty) {
      _selectedPlatform = _platforms.first['id']!;
      _selectedPlatformName = _platforms.first['name']!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    final res = await DramaRepository.search(_selectedPlatform, _controller.text);
    if (mounted) {
      setState(() {
        _results = res;
        _isLoading = false;
      });
    }
  }

  void _changePlatform(String id, String name) {
    setState(() {
      _selectedPlatform = id;
      _selectedPlatformName = name;
    });
    if (_controller.text.isNotEmpty) _search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("PENCARIAN", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF161B22),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Platform selector
          RepaintBoundary(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _platforms.length,
                itemBuilder: (_, i) {
                  final p = _platforms[i];
                  final isSelected = _selectedPlatform == p['id'];
                  return _OptimizedPlatformChip(
                    label: p['name']!,
                    isSelected: isSelected,
                    onTap: () => _changePlatform(p['id']!, p['name']!),
                  );
                },
              ),
            ),
          ),
          
          // Search bar
          RepaintBoundary(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _searchFocus,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Cari drama...",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF1F2937),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF06B6D4)),
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => _search(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06B6D4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("CARI", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
          
          // Results grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF06B6D4)))
                : _results.isEmpty
                    ? RepaintBoundary(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search_off, color: Colors.white24, size: 48),
                              const SizedBox(height: 12),
                              Text(
                                _controller.text.isEmpty 
                                    ? "Masukkan judul drama" 
                                    : "Tidak ada hasil untuk '${_controller.text}'",
                                style: const TextStyle(color: Colors.white38),
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
                          itemCount: _results.length,
                          itemBuilder: (_, i) {
                            final item = _results[i];
                            return RepaintBoundary(
                              key: ValueKey('search_${item['id']}_$i'),
                              child: _OptimizedSearchCard(
                                item: item,
                                platformId: _selectedPlatform,
                                onTap: () {
                                  context.navigateToPlayer(
                                    id: item['id'].toString(),
                                    source: _selectedPlatform,
                                    title: item['title'] ?? 'Drama',
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// OPTIMIZED PLATFORM CHIP - Separate widget
// ============================================================
class _OptimizedPlatformChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptimizedPlatformChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF06B6D4).withOpacity(0.2)
              : const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF06B6D4) : Colors.white12,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF06B6D4) : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// OPTIMIZED SEARCH CARD - Separate widget
// ============================================================
class _OptimizedSearchCard extends StatelessWidget {
  final dynamic item;
  final String platformId;
  final VoidCallback onTap;

  const _OptimizedSearchCard({
    required this.item,
    required this.platformId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Poster image
              CachedNetworkImage(
                imageUrl: item['cover'] ?? '',
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: const Color(0xFF1A2232)),
                errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A2232)),
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
                      // Episode count badge
                      if (item['chapters'] != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFF06B6D4).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            '${item['chapters']} Ep',
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
                        item['title'] ?? '',
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
            ],
          ),
        ),
      ),
    );
  }
}
