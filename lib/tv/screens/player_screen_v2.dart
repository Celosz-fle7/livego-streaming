import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../services/drama_repository.dart';

class TVPlayerScreen extends StatefulWidget {
  final String id;
  final String source;
  final String title;

  const TVPlayerScreen({
    super.key,
    required this.id,
    required this.source,
    required this.title,
  });

  @override
  State<TVPlayerScreen> createState() => _TVPlayerScreenState();
}

class _TVPlayerScreenState extends State<TVPlayerScreen> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'tv_player_v2');

  VideoPlayerController? _controller;

  bool _loading = true;
  bool _error = false;
  bool _showControls = true;
  bool _playing = false;

  int _episode = 1;
  int _totalEpisodes = 1;

  double _position = 0;
  double _duration = 1;

  Timer? _hideTimer;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    _loadDetailAndVideo();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _progressTimer?.cancel();
    _controller?.dispose();
    _focusNode.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    super.dispose();
  }

  Future<void> _loadDetailAndVideo() async {
    try {
      final detail = await DramaRepository.getDetail(
        widget.id,
        widget.source,
      );

      final rawTotal = detail?['total_episodes'] ??
          detail?['chapters'] ??
          detail?['total_chapter'] ??
          1;

      _totalEpisodes = int.tryParse(rawTotal.toString()) ?? 1;
    } catch (_) {}

    await _loadEpisode(_episode);
  }

  Future<void> _loadEpisode(int ep) async {
    setState(() {
      _loading = true;
      _error = false;
      _episode = ep;
      _position = 0;
    });

    _progressTimer?.cancel();

    final old = _controller;
    _controller = null;
    await old?.dispose();

    try {
      final data = await DramaRepository.getVideo(
        widget.id,
        widget.source,
        episode: ep,
      );

      final url = (data?['video_url'] ?? data?['url'] ?? '').toString();

      if (url.isEmpty) {
        throw Exception('URL video kosong');
      }

      final ctrl = VideoPlayerController.networkUrl(Uri.parse(url));
      _controller = ctrl;

      await ctrl.initialize();

      if (!mounted) return;

      _duration = ctrl.value.duration.inSeconds.toDouble().clamp(1, 999999);
      _playing = true;
      _loading = false;
      _error = false;

      await ctrl.play();

      _startProgress();
      _resetHideTimer();

      setState(() {});
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  void _startProgress() {
    _progressTimer?.cancel();

    _progressTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final ctrl = _controller;
        if (!mounted || ctrl == null || !ctrl.value.isInitialized) return;

        final pos = ctrl.value.position.inSeconds.toDouble();
        final dur = ctrl.value.duration.inSeconds.toDouble().clamp(1, 999999);

        setState(() {
          _position = pos;
          _duration = dur.toDouble();
          _playing = ctrl.value.isPlaying;
        });

        if (pos >= dur - 1 && _episode < _totalEpisodes) {
          _loadEpisode(_episode + 1);
        }
      },
    );
  }

  void _togglePlay() {
    final ctrl = _controller;
    if (ctrl == null) return;

    if (ctrl.value.isPlaying) {
      ctrl.pause();
    } else {
      ctrl.play();
    }

    setState(() {
      _playing = ctrl.value.isPlaying;
      _showControls = true;
    });

    _resetHideTimer();
  }

  void _seek(double delta) {
    final ctrl = _controller;
    if (ctrl == null) return;

    final next = (_position + delta).clamp(0.0, _duration);

    ctrl.seekTo(Duration(seconds: next.toInt()));

    setState(() {
      _position = next;
      _showControls = true;
    });

    _resetHideTimer();
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();

    setState(() {
      _showControls = true;
    });

    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.goBack ||
        key == LogicalKeyboardKey.escape) {
      Navigator.pop(context);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.select ||
        key == LogicalKeyboardKey.mediaPlayPause) {
      _togglePlay();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.mediaFastForward) {
      _seek(10);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.mediaRewind) {
      _seek(-10);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp ||
        key == LogicalKeyboardKey.arrowDown) {
      _resetHideTimer();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  String _fmt(double value) {
    final total = value.toInt();
    final m = total ~/ 60;
    final s = total % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _onKey,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: _resetHideTimer,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildVideo(),

              if (_loading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF04D2FF),
                  ),
                ),

              if (_error)
                _buildError(),

              if (_showControls && !_loading && !_error)
                _buildControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideo() {
    final ctrl = _controller;

    if (ctrl == null || !ctrl.value.isInitialized) {
      return const SizedBox.expand();
    }

    return Center(
      child: AspectRatio(
        aspectRatio: ctrl.value.aspectRatio,
        child: VideoPlayer(ctrl),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white38,
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'Gagal memuat video',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _loadEpisode(_episode),
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(36, 34, 36, 80),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.85),
                  Colors.transparent,
                ],
              ),
            ),
            child: Text(
              '${widget.title} • Episode $_episode/$_totalEpisodes',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Center(
          child: Icon(
            _playing ? Icons.pause_circle : Icons.play_circle,
            color: Colors.white70,
            size: 86,
          ),
        ),

        Positioned(
          left: 36,
          right: 36,
          bottom: 34,
          child: Column(
            children: [
              LinearProgressIndicator(
                value: _duration <= 0 ? 0 : _position / _duration,
                minHeight: 6,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation(
                  Color(0xFF04D2FF),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fmt(_position),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    _fmt(_duration),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
