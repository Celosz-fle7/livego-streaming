// lib/tv/screens/player_screen.dart
// LIVEGO TV - PLAYER SCREEN + HISTORY + SUBTITLE + QUALITY FIX

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../services/drama_repository.dart';
import '../../database/database_helper.dart';

class TVPlayerScreen extends StatefulWidget {
  final String id, source, title;
  const TVPlayerScreen({
    super.key,
    required this.id,
    required this.source,
    required this.title,
  });
  @override
  State<TVPlayerScreen> createState() => _TVPlayerScreenState();
}

enum _PlayerState { loading, playing, paused, error }

class _TVPlayerScreenState extends State<TVPlayerScreen> {
  VideoPlayerController? _controller;
  _PlayerState _playerState = _PlayerState.loading;
  String? _errorMessage;
  int _currentEpisode = 1;
  int _totalEpisodes = 1;
  bool _isPlaying = false;
  String _selectedQuality = 'Auto';
  List<int> _episodes = [];
  Map<String, dynamic>? _detail;

  bool _showControls = false;
  bool _showTvEpisodePanel = false;

  double _currentPositionInSeconds = 0.0;
  double _totalDurationInSeconds = 1.0;

  final FocusNode _tvPlayerFocusNode = FocusNode();
  Timer? _progressTimer;

  // 🔥 SUBTITLE
  String? _subtitleUrl;
  bool _showSubtitle = false;

  // 🔥 QUALITY
  final List<String> _qualities = ['Auto', '380p', '480p', '560p', '720p', '1080p'];
  int _qualityIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tvPlayerFocusNode.requestFocus();
    });
    _loadDetail();
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _controller?.removeListener(_onPlayerUpdate);
    _controller?.dispose();
    _tvPlayerFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadDetail() async {
    final detail = await DramaRepository.getDetail(widget.id, widget.source);
    if (!mounted) return;
    if (detail != null) {
      final eps = detail['total_episodes'] ?? detail['total_chapter'] ?? detail['totalEpisode'] ?? 1;
      final total = eps is int ? eps : int.tryParse(eps.toString()) ?? 1;
      setState(() {
        _detail = detail;
        _totalEpisodes = total;
        _episodes = List.generate(total, (i) => i + 1);
      });
    }
    _loadEpisode(1);
  }

  Future<void> _loadEpisode(int ep) async {
    if (!mounted) return;
    _progressTimer?.cancel();

    setState(() {
      _playerState = _PlayerState.loading;
      _errorMessage = null;
      _isPlaying = false;
    });

    final oldCtrl = _controller;
    _controller?.removeListener(_onPlayerUpdate);
    _controller = null;
    await oldCtrl?.dispose();

    // 🔥 KIRIM PARAMETER KUALITAS
    final quality = _selectedQuality != 'Auto' ? _selectedQuality : null;
    final data = await DramaRepository.getVideo(widget.id, widget.source, episode: ep, quality: quality);
    if (!mounted) return;

    final url = (data?['video_url'] ?? '').toString();
    if (url.isEmpty) {
      setState(() {
        _playerState = _PlayerState.error;
        _errorMessage = 'URL video kosong';
      });
      return;
    }

    // 🔥 SIMPAN SUBTITLE URL
    _subtitleUrl = data?['subtitle_url'];

    final ctrl = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller = ctrl;

    try {
      await ctrl.initialize();
      if (!mounted || _controller != ctrl) {
        ctrl.dispose();
        return;
      }

      ctrl.addListener(_onPlayerUpdate);

      setState(() {
        _currentEpisode = ep;
        _totalDurationInSeconds = ctrl.value.duration.inSeconds.toDouble().clamp(1, 99999);
        _currentPositionInSeconds = 0;
        _isPlaying = true;
        _playerState = _PlayerState.playing;
      });

      ctrl.play();

      // 🔥 SIMPAN KE HISTORY
      DatabaseHelper().addToHistory(
        dramaId: widget.id,
        dramaTitle: widget.title,
        dramaPoster: _detail?['cover'] ?? '',
        platform: widget.source,
        episode: ep,
      );

      _progressTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted || _controller == null) return;
        final pos = _controller!.value.position.inSeconds.toDouble();
        _currentPositionInSeconds = pos;
        if (pos >= _totalDurationInSeconds && _totalDurationInSeconds > 1 && _currentEpisode < _totalEpisodes) {
          _progressTimer?.cancel();
          _loadEpisode(_currentEpisode + 1);
          return;
        }
        if (_showControls && mounted) setState(() {});
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _playerState = _PlayerState.error;
          _errorMessage = 'Gagal memuat: ${e.toString()}';
        });
      }
    }
  }

  void _onPlayerUpdate() {
    if (!mounted || _controller == null) return;
    final playing = _controller!.value.isPlaying;
    if (playing != _isPlaying) {
      setState(() {
        _isPlaying = playing;
        _playerState = playing ? _PlayerState.playing : _PlayerState.paused;
      });
    }
  }

  void _togglePlayPause() {
    if (_controller == null) return;
    setState(() => _isPlaying = !_isPlaying);
    _isPlaying ? _controller!.play() : _controller!.pause();
  }

  void _seek(double delta) {
    final newPos = (_currentPositionInSeconds + delta).clamp(0.0, _totalDurationInSeconds);
    _controller?.seekTo(Duration(seconds: newPos.toInt()));
    setState(() => _currentPositionInSeconds = newPos);
  }

  void _nextEpisode() {
    if (_currentEpisode < _totalEpisodes) _loadEpisode(_currentEpisode + 1);
  }

  void _prevEpisode() {
    if (_currentEpisode > 1) _loadEpisode(_currentEpisode - 1);
  }

  void _cycleQuality() {
    _qualityIndex = (_qualityIndex + 1) % _qualities.length;
    setState(() => _selectedQuality = _qualities[_qualityIndex]);
    _loadEpisode(_currentEpisode);
  }

  void _toggleSubtitle() {
    setState(() => _showSubtitle = !_showSubtitle);
  }

  KeyEventResult _onTvKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape || key == LogicalKeyboardKey.goBack) {
      if (_showControls || _showTvEpisodePanel) {
        setState(() { _showControls = false; _showTvEpisodePanel = false; });
        _tvPlayerFocusNode.requestFocus();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }

    if (!_showControls && !_showTvEpisodePanel) {
      if (key == LogicalKeyboardKey.arrowLeft) { _seek(-10); return KeyEventResult.handled; }
      if (key == LogicalKeyboardKey.arrowRight) { _seek(10); return KeyEventResult.handled; }
      if (key == LogicalKeyboardKey.arrowUp) { setState(() => _showControls = true); return KeyEventResult.handled; }
      if (key == LogicalKeyboardKey.arrowDown) { setState(() => _showTvEpisodePanel = true); return KeyEventResult.handled; }
      if (key == LogicalKeyboardKey.select || key == LogicalKeyboardKey.enter) { _togglePlayPause(); return KeyEventResult.handled; }
    }
    return KeyEventResult.ignored;
  }

  String _fmt(double s) {
    final m = (s / 60).floor();
    final ss = (s % 60).toInt();
    return '$m:${ss.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Focus(
          focusNode: _tvPlayerFocusNode, autofocus: true, onKeyEvent: _onTvKeyEvent,
          child: Stack(children: [
            RepaintBoundary(
              child: Center(
                child: AspectRatio(aspectRatio: 16 / 9, child: _buildVideoArea()),
              ),
            ),
            if (_showSubtitle && _subtitleUrl != null) _buildSubtitleOverlay(),
            if (_showControls) RepaintBoundary(child: _buildTvBottomNavbar()),
            if (_showTvEpisodePanel) RepaintBoundary(child: _buildTvSideEpisodePanel()),
          ]),
        ),
      ),
    );
  }

  Widget _buildSubtitleOverlay() {
    return Positioned(
      bottom: 40, left: 40, right: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(8)),
        child: const Text('Subtitle aktif', style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildVideoArea() {
    switch (_playerState) {
      case _PlayerState.loading:
        return Container(color: const Color(0xFF151515),
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            const CircularProgressIndicator(color: Color(0xFF04D2FF)), const SizedBox(height: 12),
            Text('${widget.title} • Eps $_currentEpisode/$_totalEpisodes', style: const TextStyle(color: Color(0xFF04D2FF), fontSize: 13)),
          ])));
      case _PlayerState.error:
        return Container(color: const Color(0xFF151515),
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.error_outline, color: Colors.white38, size: 48), const SizedBox(height: 12),
            Text(_errorMessage ?? 'Gagal memuat video', style: const TextStyle(color: Colors.white38, fontSize: 14), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextButton(onPressed: () => _loadEpisode(_currentEpisode), child: const Text('Coba Lagi', style: TextStyle(color: Color(0xFF04D2FF)))),
          ])));
      case _PlayerState.playing:
      case _PlayerState.paused:
        if (_controller == null || !_controller!.value.isInitialized) return Container(color: const Color(0xFF151515));
        return Stack(fit: StackFit.expand, children: [
          VideoPlayer(_controller!),
          if (!_isPlaying) Container(color: Colors.black38, child: const Center(child: Icon(Icons.play_arrow, color: Colors.white54, size: 64))),
        ]);
    }
  }

  Widget _buildTvBottomNavbar() {
    return Positioned(left: 0, right: 0, bottom: 0,
      child: Container(height: 110,
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.95), Colors.transparent])),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: FocusScope(child: FocusTraversalGroup(policy: OrderedTraversalPolicy(),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              _buildTvNavButton(Icons.skip_previous, _prevEpisode), const SizedBox(width: 12),
              _buildTvNavButton(_isPlaying ? Icons.pause : Icons.play_arrow, _togglePlayPause, isPlayBtn: true), const SizedBox(width: 12),
              _buildTvNavButton(Icons.skip_next, _nextEpisode),
            ]),
            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(children: [
                Text(_fmt(_currentPositionInSeconds), style: const TextStyle(color: Colors.white60, fontSize: 12)),
                Expanded(child: SliderTheme(data: SliderThemeData(trackHeight: 4, activeTrackColor: const Color(0xFF04D2FF), inactiveTrackColor: Colors.white24, thumbColor: Colors.white, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5), overlayShape: SliderComponentShape.noOverlay),
                  child: Slider(value: _currentPositionInSeconds.clamp(0, _totalDurationInSeconds), max: _totalDurationInSeconds,
                    onChanged: (v) { setState(() => _currentPositionInSeconds = v); _controller?.seekTo(Duration(seconds: v.toInt())); }))),
                Text(_fmt(_totalDurationInSeconds), style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ]))),
            _buildTvNavButton(Icons.closed_caption, _toggleSubtitle, label: _showSubtitle ? 'ON' : 'OFF'),
            const SizedBox(width: 8),
            _buildTvNavButton(Icons.hd, _cycleQuality, label: _selectedQuality),
          ])))),
    );
  }


  Widget _buildTvSideEpisodePanel() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 300, height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          border: const Border(left: BorderSide(color: Colors.white12)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20)],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: FocusScope(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Daftar Episode', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              _buildTvNavButton(Icons.close, () => setState(() => _showTvEpisodePanel = false)),
            ]),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.2),
                itemCount: _episodes.length,
                itemBuilder: (_, i) {
                  final ep = _episodes[i];
                  final isCurrent = ep == _currentEpisode;
                  return RepaintBoundary(
                    child: Focus(
                      autofocus: i == 0 && _currentEpisode == 1,
                      onKeyEvent: (node, event) {
                        if (event is KeyDownEvent && (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.select)) {
                          _loadEpisode(ep);
                          setState(() => _showTvEpisodePanel = false);
                          _tvPlayerFocusNode.requestFocus();
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: Builder(builder: (ctx) {
                        final focused = Focus.of(ctx).hasFocus;
                        return AnimatedScale(
                          scale: focused ? 1.1 : 1.0, duration: const Duration(milliseconds: 120),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 120),
                            decoration: BoxDecoration(
                              color: isCurrent ? const Color(0xFFFF003F) : (focused ? Colors.white24 : Colors.white10),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focused ? const Color(0xFF04D2FF) : Colors.transparent, width: 2),
                            ),
                            child: Center(child: Text('$ep', style: TextStyle(color: Colors.white, fontWeight: isCurrent || focused ? FontWeight.bold : FontWeight.normal))),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
  Widget _buildTvNavButton(IconData icon, VoidCallback onTap, {bool isPlayBtn = false, String? label}) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent && (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.select)) { onTap(); return KeyEventResult.handled; }
        return KeyEventResult.ignored;
      },
      child: Builder(builder: (ctx) {
        final focused = Focus.of(ctx).hasFocus;
        if (isPlayBtn) {
          return AnimatedScale(scale: focused ? 1.15 : 1.0, duration: const Duration(milliseconds: 120),
            child: AnimatedContainer(duration: const Duration(milliseconds: 120), width: 46, height: 46,
              decoration: BoxDecoration(color: focused ? const Color(0xFF04D2FF) : Colors.white, shape: BoxShape.circle, boxShadow: focused ? [const BoxShadow(color: Color(0xFF04D2FF), blurRadius: 10)] : null),
              child: Icon(icon, color: Colors.black, size: 26)));
        }
        return AnimatedScale(scale: focused ? 1.1 : 1.0, duration: const Duration(milliseconds: 120),
          child: AnimatedContainer(duration: const Duration(milliseconds: 120),
            padding: label != null ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6) : const EdgeInsets.all(8),
            decoration: BoxDecoration(color: focused ? Colors.white24 : Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: focused ? const Color(0xFF04D2FF) : Colors.transparent, width: 1.5)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, color: focused ? const Color(0xFF04D2FF) : Colors.white70, size: 20),
              if (label != null) ...[const SizedBox(width: 6), Text(label, style: TextStyle(color: focused ? const Color(0xFF04D2FF) : Colors.white, fontSize: 12, fontWeight: FontWeight.bold))],
            ])));
      }),
    );
  }
}