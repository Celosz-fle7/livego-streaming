// lib/tv/screens/history_screen.dart
// LIVEGO TV - HISTORY SCREEN
// Full TV Optimization Checklist

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../database/database_helper.dart';
import 'player_screen.dart';

class TVHistoryScreen extends StatefulWidget {
  const TVHistoryScreen({super.key});
  @override
  State<TVHistoryScreen> createState() => _TVHistoryScreenState();
}

class _TVHistoryScreenState extends State<TVHistoryScreen> {
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = true;
  int _selectedIndex = 0;
  final FocusNode _gridFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  static const int _cols = 6;
  static const double _cardAspect = 0.7;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gridFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _gridFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final db = DatabaseHelper();
    final data = await db.getHistory();
    if (mounted) {
      setState(() {
        _history = data;
        _isLoading = false;
        _selectedIndex = (_selectedIndex >= data.length) ? 0 : _selectedIndex;
      });
    }
  }

  Future<void> _clearHistory() async {
    await DatabaseHelper().clearHistory();
    _loadHistory();
  }

  void _scrollToSelected(int index) {
    if (!_scrollController.hasClients) return;
    final row = index ~/ _cols;
    final screenW = MediaQuery.of(context).size.width - 48;
    final itemW = screenW / _cols;
    final itemH = itemW / _cardAspect;
    final target = row * (itemH + 12);
    final maxScroll = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      target.clamp(0.0, maxScroll),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
    );
  }

  void _playSelected() {
    if (_history.isEmpty) return;
    final item = _history[_selectedIndex];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TVPlayerScreen(
          id: item['drama_id'].toString(),
          source: item['platform'] ?? '',
          title: item['drama_title'] ?? '',
        ),
      ),
    ).then((_) {
      _loadHistory();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _gridFocus.requestFocus();
      });
    });
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape || key == LogicalKeyboardKey.goBack) {
      Navigator.pop(context);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowRight) {
      if (_selectedIndex % _cols < _cols - 1 && _selectedIndex < _history.length - 1) {
        setState(() => _selectedIndex++);
        _scrollToSelected(_selectedIndex);
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowLeft) {
      if (_selectedIndex % _cols > 0) {
        setState(() => _selectedIndex--);
        _scrollToSelected(_selectedIndex);
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      if (_selectedIndex + _cols < _history.length) {
        setState(() => _selectedIndex += _cols);
        _scrollToSelected(_selectedIndex);
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      if (_selectedIndex - _cols >= 0) {
        setState(() => _selectedIndex -= _cols);
        _scrollToSelected(_selectedIndex);
      }
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.select) {
      _playSelected();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080C12),
      body: Focus(
        focusNode: _gridFocus,
        autofocus: true,
        onKeyEvent: _onKeyEvent,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              RepaintBoundary(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'RIWAYAT TONTONAN',
                      style: TextStyle(
                        color: Color(0xFF06B6D4),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_history.isNotEmpty) _buildClearButton(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: Color(0xFF06B6D4)))
                    : _history.isEmpty
                        ? const Center(
                            child: Text(
                              'Belum ada riwayat',
                              style: TextStyle(color: Colors.white38, fontSize: 16),
                            ),
                          )
                        : RepaintBoundary(
                            child: FocusScope(
                              child: GridView.builder(
                                controller: _scrollController,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _cols,
                                  childAspectRatio: _cardAspect,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: _history.length,
                                itemBuilder: (context, i) {
                                  return RepaintBoundary(
                                    key: ValueKey('hist_${_history[i]['drama_id']}_$i'),
                                    child: _OptimizedHistoryCard(
                                      item: _history[i],
                                      isFocused: _selectedIndex == i,
                                      onTap: () {
                                        setState(() => _selectedIndex = i);
                                        _playSelected();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
              ),
              const SizedBox(height: 8),
              RepaintBoundary(
                child: Center(
                  child: Text(
                    "▲▼◀▶ = Navigasi | ENTER = Play | ESC = Kembali",
                    style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return GestureDetector(
      onTap: _clearHistory,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.withOpacity(0.5)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_outline, color: Colors.red, size: 16),
            SizedBox(width: 6),
            Text('HAPUS SEMUA', style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _OptimizedHistoryCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isFocused;
  final VoidCallback onTap;

  const _OptimizedHistoryCard({
    required this.item,
    required this.isFocused,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isFocused ? 1.04 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isFocused ? const Color(0xFF06B6D4) : Colors.transparent,
            width: 3,
          ),
          boxShadow: isFocused
              ? [
                  BoxShadow(
                    color: const Color(0xFF06B6D4).withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: item['drama_poster'] ?? '',
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: const Color(0xFF1A2232)),
                errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A2232)),
              ),
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
                      Text(
                        'Eps ${item['episode'] ?? 1}',
                        style: const TextStyle(
                          color: Color(0xFF06B6D4),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
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
              if (isFocused)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF06B6D4), width: 2),
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
