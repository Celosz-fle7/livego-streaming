// lib/tv/screens/search_screen.dart
// LIVEGO TV - SEARCH SCREEN
// Full TV Optimization Checklist

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/drama_repository.dart';
import '../../utils/mapping.dart';
import 'player_screen.dart';

class TVSearchScreen extends StatefulWidget {
  const TVSearchScreen({super.key});
  @override
  State<TVSearchScreen> createState() => _TVSearchScreenState();
}

class _TVSearchScreenState extends State<TVSearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _inputFocus = FocusNode();
  final FocusNode _rootFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  List _results = [];
  bool _loading = false;
  bool _inputFocused = false;
  int _selectedPlatformIndex = 0;
  int _selectedResultIndex = 0;
  String _focusArea = 'platform';

  late final List<Map<String, String>> _platforms;

  static const int _cols = 6;
  static const double _cardAspect = 0.65;

  @override
  void initState() {
    super.initState();
    _platforms = AppMapping.searchablePlatforms;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rootFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _inputFocus.dispose();
    _rootFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String get _selectedPlatformId =>
      _platforms.isNotEmpty ? _platforms[_selectedPlatformIndex]['id']! : '';

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;
    setState(() => _loading = true);
    final data = await DramaRepository.search(_selectedPlatformId, query);
    if (!mounted) return;
    setState(() {
      _results = data;
      _loading = false;
      _selectedResultIndex = 0;
      if (data.isNotEmpty) _focusArea = 'grid';
    });
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
  }

  void _scrollToSelected(int index) {
    if (!_scrollController.hasClients) return;
    final row = index ~/ _cols;
    final screenW = MediaQuery.of(context).size.width - 32;
    final itemW = screenW / _cols;
    final itemH = itemW / _cardAspect;
    final target = row * (itemH + 14);
    final maxScroll = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      target.clamp(0.0, maxScroll),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
    );
  }

  void _playSelected() {
    if (_results.isEmpty) return;
    final item = _results[_selectedResultIndex];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TVPlayerScreen(
          id: item['id'].toString(),
          source: _selectedPlatformId,
          title: item['title'] ?? 'Drama',
        ),
      ),
    ).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _rootFocus.requestFocus();
      });
      _search(_ctrl.text);
    });
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape || key == LogicalKeyboardKey.goBack) {
      Navigator.pop(context);
      return KeyEventResult.handled;
    }

    if (_focusArea == 'platform') {
      if (key == LogicalKeyboardKey.arrowRight && _selectedPlatformIndex < _platforms.length - 1) {
        setState(() => _selectedPlatformIndex++);
      } else if (key == LogicalKeyboardKey.arrowLeft && _selectedPlatformIndex > 0) {
        setState(() => _selectedPlatformIndex--);
      } else if (key == LogicalKeyboardKey.arrowDown) {
        setState(() => _focusArea = 'input');
        WidgetsBinding.instance.addPostFrameCallback((_) => _inputFocus.requestFocus());
      } else if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.select) {
        if (_ctrl.text.isNotEmpty) _search(_ctrl.text);
      }
    } else if (_focusArea == 'input') {
      if (key == LogicalKeyboardKey.arrowUp) {
        setState(() => _focusArea = 'platform');
        _rootFocus.requestFocus();
      } else if (key == LogicalKeyboardKey.arrowDown && _results.isNotEmpty) {
        setState(() => _focusArea = 'grid');
        _rootFocus.requestFocus();
      } else if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.select) {
        if (_ctrl.text.isNotEmpty) _search(_ctrl.text);
      }
    } else if (_focusArea == 'grid') {
      if (key == LogicalKeyboardKey.arrowRight) {
        if (_selectedResultIndex % _cols < _cols - 1 && _selectedResultIndex < _results.length - 1) {
          setState(() => _selectedResultIndex++);
          _scrollToSelected(_selectedResultIndex);
        }
      } else if (key == LogicalKeyboardKey.arrowLeft) {
        if (_selectedResultIndex % _cols == 0) {
          setState(() => _focusArea = 'platform');
        } else {
          setState(() => _selectedResultIndex--);
          _scrollToSelected(_selectedResultIndex);
        }
      } else if (key == LogicalKeyboardKey.arrowDown) {
        if (_selectedResultIndex + _cols < _results.length) {
          setState(() => _selectedResultIndex += _cols);
          _scrollToSelected(_selectedResultIndex);
        }
      } else if (key == LogicalKeyboardKey.arrowUp) {
        if (_selectedResultIndex < _cols) {
          setState(() => _focusArea = 'input');
          WidgetsBinding.instance.addPostFrameCallback((_) => _inputFocus.requestFocus());
        } else {
          setState(() => _selectedResultIndex -= _cols);
          _scrollToSelected(_selectedResultIndex);
        }
      } else if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.select) {
        _playSelected();
      }
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D111A),
      body: Focus(
        focusNode: _rootFocus,
        autofocus: true,
        onKeyEvent: _onKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepaintBoundary(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                color: const Color(0xFF161B26),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF06B6D4), size: 24),
                    const SizedBox(width: 12),
                    const Text('CARI DRAMA',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text('▲▼◀▶ = Navigasi | ENTER = Pilih | ESC = Kembali',
                        style: TextStyle(color: Colors.white38, fontSize: 11)),
                  ],
                ),
              ),
            ),
            RepaintBoundary(
              child: FocusTraversalGroup(
                policy: WidgetOrderTraversalPolicy(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_platforms.length, (i) {
                        final isFocused = _focusArea == 'platform' && _selectedPlatformIndex == i;
                        final isSelected = _selectedPlatformId == _platforms[i]['id'];
                        return _OptimizedPlatformChip(
                          label: _platforms[i]['name']!,
                          isFocused: isFocused,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() => _selectedPlatformIndex = i);
                            if (_ctrl.text.isNotEmpty) _search(_ctrl.text);
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Focus(
                  focusNode: _inputFocus,
                  onFocusChange: (f) => setState(() => _inputFocused = f),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _inputFocused ? const Color(0xFF06B6D4) : Colors.white10,
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textInputAction: TextInputAction.search,
                      onSubmitted: _search,
                      decoration: const InputDecoration(
                        hintText: 'Ketik judul drama...',
                        hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF06B6D4)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF06B6D4)))
                  : _results.isEmpty
                      ? RepaintBoundary(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.movie_outlined, color: Colors.white24, size: 48),
                                SizedBox(height: 12),
                                Text('Cari drama favoritmu', style: TextStyle(color: Colors.white38)),
                              ],
                            ),
                          ),
                        )
                      : RepaintBoundary(
                          child: FocusScope(
                            child: GridView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(16),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _cols,
                                childAspectRatio: _cardAspect,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                              ),
                              itemCount: _results.length,
                              itemBuilder: (_, i) {
                                final item = _results[i];
                                final isFocused = _focusArea == 'grid' && _selectedResultIndex == i;
                                return RepaintBoundary(
                                  key: ValueKey('search_${item['id']}_$i'),
                                  child: _OptimizedSearchResultCard(
                                    item: item,
                                    isFocused: isFocused,
                                    onTap: () {
                                      setState(() => _selectedResultIndex = i);
                                      _playSelected();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptimizedPlatformChip extends StatelessWidget {
  final String label;
  final bool isFocused;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptimizedPlatformChip({
    required this.label,
    required this.isFocused,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isFocused ? 1.06 : 1.0),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isFocused
              ? const Color(0xFF06B6D4)
              : isSelected
                  ? const Color(0xFF06B6D4).withOpacity(0.2)
                  : const Color(0xFF1A2232),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isFocused || isSelected ? const Color(0xFF06B6D4) : Colors.white10,
            width: isFocused ? 2 : 1,
          ),
          boxShadow: isFocused
              ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.4), blurRadius: 8)]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isFocused
                ? Colors.black
                : (isSelected ? const Color(0xFF06B6D4) : Colors.white60),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _OptimizedSearchResultCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isFocused;
  final VoidCallback onTap;

  const _OptimizedSearchResultCard({
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
              ? [BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.3), blurRadius: 12, spreadRadius: 2)]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: item['cover'] ?? '',
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: const Color(0xFF1A2232)),
                errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A2232)),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.85), Colors.transparent],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        item['title'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
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
