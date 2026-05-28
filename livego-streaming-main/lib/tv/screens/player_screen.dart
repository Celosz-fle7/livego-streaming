// lib/tv/screens/player_screen.dart
// LIVEGO TV PLAYER V2 - Cloudflare API + Android TV Focus Safe

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../database/database_helper.dart';
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

enum _PlayerState { loading, playing, paused, error }

class _SeekBackIntent extends Intent {
  const _SeekBackIntent();
}

class _SeekForwardIntent extends Intent {
  const _SeekForwardIntent();
}

class _TogglePlayIntent extends Intent {
  const _TogglePlayIntent();
}

class _ShowControlsIntent extends Intent {
  const _ShowControlsIntent();
}

class _ShowEpisodesIntent extends Intent {
  const _ShowEpisodesIntent();
}

class _BackIntent extends Intent {
  const _BackIntent();
}

class _NextEpisodeIntent extends Intent {
  const _NextEpisodeIntent();
}

class _PrevEpisodeIntent extends Intent {
  const _PrevEpisodeIntent();
}

class _TVPlayerScreenState extends State<TVPlayerScreen>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;

  final FocusNode _rootFocusNode = FocusNode(debugLabel: 'tv_player_root');
  final FocusScopeNode _controlsFocusNode = FocusScopeNode(debugLabel: 'tv_controls');
  final FocusScopeNode _episodePanelFocusNode =
      FocusScopeNode(debugLabel: 'tv_episode_panel');

  final ScrollController _episodeScrollController = ScrollController();

  Timer? _progressTimer;
  Timer? _hideControlsTimer;
  Timer? _focusRecoveryTimer;

  _PlayerState _playerState = _PlayerState.loading;

  Map<String, dynamic>? _detail;

  String? _errorMessage;
  String? _subtitleUrl;

  int _currentEpisode = 1;
  int _totalEpisodes = 1;
  int _loadingToken = 0;
  int _retryCount = 0;

  static const int _maxRetry = 2;

  bool _isPlaying = false;
  bool _showControls = true;
  bool _showEpisodePanel = false;
  bool _showSubtitle = false;
  bool _autoNextLock = false;
  bool _didSaveHistory = false;

  double _positionSeconds = 0.0;
  double _durationSeconds = 1.0;

  final List<int> _episodes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestRootFocus();
    });

    _loadDetail();
    _startProgressTimer();
    _resetHideControlsTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final ctrl = _controller;
    if (ctrl == null) return;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      ctrl.pause();
    }

    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      _recoverFocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _progressTimer?.cancel();
    _hideControlsTimer?.cancel();
    _focusRecoveryTimer?.cancel();

    _controller?.removeListener(_onPlayerUpdate);
    _controller?.dispose();

    _rootFocusNode.dispose();
    _controlsFocusNode.dispose();
    _episodePanelFocusNode.dispose();
    _episodeScrollController.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    super.dispose();
  }

  Future<void> _loadDetail() async {
    final detail = await DramaRepository.getDetail(
      widget.id,
      widget.source,
      forceRefresh: true,
    );

    if (!mounted) return;

    int total = 1;

    if (detail != null) {
      final raw = detail['total_episodes'] ??
          detail['total_chapter'] ??
          detail['totalEpisode'] ??
          detail['chapters'] ??
          1;

      total = raw is int ? raw : int.tryParse(raw.toString()) ?? 1;
    }

    setState(() {
      _detail = detail;
      _totalEpisodes = total < 1 ? 1 : total;
      _episodes
        ..clear()
        ..addAll(List.generate(_totalEpisodes, (i) => i + 1));
    });

    await _loadEpisode(1, resetRetry: true);
  }

  Future<void> _loadEpisode(
    int episode, {
    bool resetRetry = true,
  }) async {
    if (!mounted) return;

    final safeEpisode = episode.clamp(1, _totalEpisodes);
    final token = ++_loadingToken;

    if (resetRetry) {
      _retryCount = 0;
    }

    _autoNextLock = false;
    _didSaveHistory = false;

    setState(() {
      _playerState = _PlayerState.loading;
      _errorMessage = null;
      _isPlaying = false;
      _showControls = true;
      _showEpisodePanel = false;
      _positionSeconds = 0;
      _durationSeconds = 1;
      _currentEpisode = safeEpisode;
    });

    _resetHideControlsTimer();

    final old = _controller;
    old?.removeListener(_onPlayerUpdate);
    _controller = null;
    await old?.dispose();

    try {
      final data = await DramaRepository.getVideo(
        widget.id,
        widget.source,
        episode: safeEpisode,
        forceRefresh: true,
      );

      if (!mounted || token != _loadingToken) return;

      final videoUrl = (data?['video_url'] ?? data?['url'] ?? '').toString();
      _subtitleUrl = (data?['subtitle_url'] ?? '').toString();

      if (videoUrl.isEmpty) {
        _failOrRetry(safeEpisode, 'URL video kosong');
        return;
      }

      final ctrl = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      _controller = ctrl;

      await ctrl.initialize();

      if (!mounted || token != _loadingToken || _controller != ctrl) {
        await ctrl.dispose();
        return;
      }

      ctrl.addListener(_onPlayerUpdate);

      final duration = ctrl.value.duration.inSeconds.toDouble();

      setState(() {
        _durationSeconds = duration <= 0 ? 1 : duration;
        _positionSeconds = 0;
        _isPlaying = true;
        _playerState = _PlayerState.playing;
        _errorMessage = null;
      });

      await ctrl.play();
      _saveHistoryOnce();
      _recoverFocus();
    } catch (e) {
      if (!mounted || token != _loadingToken) return;
      _failOrRetry(safeEpisode, 'Gagal memuat video: $e');
    }
  }

  void _failOrRetry(int episode, String message) {
    if (_retryCount < _maxRetry) {
      _retryCount++;
      Future.delayed(Duration(seconds: 2 + _retryCount), () {
        if (mounted) {
          _loadEpisode(episode, resetRetry: false);
        }
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      _playerState = _PlayerState.error;
      _errorMessage = message;
      _isPlaying = false;
    });

    _recoverFocus();
  }

  void _onPlayerUpdate() {
    final ctrl = _controller;
    if (!mounted || ctrl == null || !ctrl.value.isInitialized) return;

    final isPlaying = ctrl.value.isPlaying;
    final state = isPlaying ? _PlayerState.playing : _PlayerState.paused;

    if (isPlaying != _isPlaying || state != _playerState) {
      setState(() {
        _isPlaying = isPlaying;
        _playerState = state;
      });
    }
  }

  void _startProgressTimer() {
    _progressTimer?.cancel();

    _progressTimer = Timer.periodic(const Duration(milliseconds: 700), (_) {
      final ctrl = _controller;

      if (!mounted || ctrl == null || !ctrl.value.isInitialized) return;

      final position = ctrl.value.position.inMilliseconds / 1000.0;
      final duration = ctrl.value.duration.inMilliseconds / 1000.0;

      final safeDuration = duration <= 0 ? 1.0 : duration;

      final shouldRebuild = _showControls ||
          _showEpisodePanel ||
          (position >= safeDuration - 1.2 && safeDuration > 2);

      _positionSeconds = position.clamp(0.0, safeDuration);
      _durationSeconds = safeDuration;

      if (position >= safeDuration - 0.8 &&
          safeDuration > 2 &&
          !_autoNextLock &&
          _currentEpisode < _totalEpisodes) {
        _autoNextLock = true;
        _loadEpisode(_currentEpisode + 1);
        return;
      }

      if (shouldRebuild && mounted) {
        setState(() {});
      }
    });
  }

  void _saveHistoryOnce() {
    if (_didSaveHistory) return;

    _didSaveHistory = true;

    DatabaseHelper().addToHistory(
      dramaId: widget.id,
      dramaTitle: widget.title,
      dramaPoster: (_detail?['cover'] ?? _detail?['image'] ?? '').toString(),
      platform: widget.source,
      episode: _currentEpisode,
    );
  }

  void _togglePlayPause() {
    final ctrl = _controller;
    if (ctrl == null || !ctrl.value.isInitialized) return;

    if (ctrl.value.isPlaying) {
      ctrl.pause();
    } else {
      ctrl.play();
    }

    _showControlsSafe();
  }

  void _seek(double seconds) {
    final ctrl = _controller;
    if (ctrl == null || !ctrl.value.isInitialized) return;

    final newPosition = (_positionSeconds + seconds).clamp(
      0.0,
      _durationSeconds,
    );

    ctrl.seekTo(Duration(milliseconds: (newPosition * 1000).round()));

    setState(() {
      _positionSeconds = newPosition;
      _showControls = true;
    });

    _resetHideControlsTimer();
  }

  void _nextEpisode() {
    if (_currentEpisode < _totalEpisodes) {
      _loadEpisode(_currentEpisode + 1, resetRetry: true);
    }
  }

  void _prevEpisode() {
    if (_currentEpisode > 1) {
      _loadEpisode(_currentEpisode - 1, resetRetry: true);
    }
  }

  void _toggleSubtitle() {
    setState(() {
      _showSubtitle = !_showSubtitle;
      _showControls = true;
    });

    _resetHideControlsTimer();
  }

  void _showControlsSafe() {
    setState(() {
      _showControls = true;
      _showEpisodePanel = false;
    });

    _resetHideControlsTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _controlsFocusNode.canRequestFocus) {
        _controlsFocusNode.requestFocus();
      }
    });
  }

  void _showEpisodePanelSafe() {
    setState(() {
      _showEpisodePanel = true;
      _showControls = false;
    });

    _hideControlsTimer?.cancel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_episodePanelFocusNode.canRequestFocus) {
        _episodePanelFocusNode.requestFocus();
      }
      _autoScrollToCurrentEpisode();
    });
  }

  void _closeOverlays() {
    setState(() {
      _showControls = false;
      _showEpisodePanel = false;
    });

    _requestRootFocus();
  }

  void _handleBack() {
    if (_showEpisodePanel || _showControls) {
      _closeOverlays();
      return;
    }

    Navigator.of(context).maybePop();
  }

  void _requestRootFocus() {
    if (!mounted) return;

    if (_rootFocusNode.canRequestFocus) {
      _rootFocusNode.requestFocus();
    }
  }

  void _recoverFocus() {
    _focusRecoveryTimer?.cancel();

    _focusRecoveryTimer = Timer(const Duration(milliseconds: 120), () {
      if (!mounted) return;

      if (_showEpisodePanel) {
        _episodePanelFocusNode.requestFocus();
      } else if (_showControls) {
        _controlsFocusNode.requestFocus();
      } else {
        _rootFocusNode.requestFocus();
      }
    });
  }

  void _resetHideControlsTimer() {
    _hideControlsTimer?.cancel();

    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted || _showEpisodePanel) return;

      setState(() {
        _showControls = false;
      });

      _requestRootFocus();
    });
  }

  void _autoScrollToCurrentEpisode() {
    if (!_episodeScrollController.hasClients) return;

    const itemHeight = 74.0;
    final row = ((_currentEpisode - 1) / 3).floor();
    final target = (row * itemHeight).toDouble();

    _episodeScrollController.animateTo(
      target.clamp(
        0.0,
        _episodeScrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  KeyEventResult _onRootKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape ||
        key == LogicalKeyboardKey.goBack ||
        key == LogicalKeyboardKey.browserBack) {
      _handleBack();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowLeft) {
      _seek(-10);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowRight) {
      _seek(10);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      _showControlsSafe();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      _showEpisodePanelSafe();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.select ||
        key == LogicalKeyboardKey.space) {
      _togglePlayPause();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  String _fmt(double seconds) {
    final value = seconds.isFinite ? seconds.floor() : 0;
    final h = value ~/ 3600;
    final m = (value % 3600) ~/ 60;
    final s = value % 60;

    if (h > 0) {
      return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }

    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Map<ShortcutActivator, Intent> get _shortcuts => const {
        SingleActivator(LogicalKeyboardKey.arrowLeft): _SeekBackIntent(),
        SingleActivator(LogicalKeyboardKey.arrowRight): _SeekForwardIntent(),
        SingleActivator(LogicalKeyboardKey.enter): _TogglePlayIntent(),
        SingleActivator(LogicalKeyboardKey.select): _TogglePlayIntent(),
        SingleActivator(LogicalKeyboardKey.space): _TogglePlayIntent(),
        SingleActivator(LogicalKeyboardKey.arrowUp): _ShowControlsIntent(),
        SingleActivator(LogicalKeyboardKey.arrowDown): _ShowEpisodesIntent(),
        SingleActivator(LogicalKeyboardKey.escape): _BackIntent(),
        SingleActivator(LogicalKeyboardKey.goBack): _BackIntent(),
        SingleActivator(LogicalKeyboardKey.pageUp): _PrevEpisodeIntent(),
        SingleActivator(LogicalKeyboardKey.pageDown): _NextEpisodeIntent(),
      };

  Map<Type, Action<Intent>> get _actions => {
        _SeekBackIntent: CallbackAction<_SeekBackIntent>(
          onInvoke: (_) {
            _seek(-10);
            return null;
          },
        ),
        _SeekForwardIntent: CallbackAction<_SeekForwardIntent>(
          onInvoke: (_) {
            _seek(10);
            return null;
          },
        ),
        _TogglePlayIntent: CallbackAction<_TogglePlayIntent>(
          onInvoke: (_) {
            _togglePlayPause();
            return null;
          },
        ),
        _ShowControlsIntent: CallbackAction<_ShowControlsIntent>(
          onInvoke: (_) {
            _showControlsSafe();
            return null;
          },
        ),
        _ShowEpisodesIntent: CallbackAction<_ShowEpisodesIntent>(
          onInvoke: (_) {
            _showEpisodePanelSafe();
            return null;
          },
        ),
        _BackIntent: CallbackAction<_BackIntent>(
          onInvoke: (_) {
            _handleBack();
            return null;
          },
        ),
        _NextEpisodeIntent: CallbackAction<_NextEpisodeIntent>(
          onInvoke: (_) {
            _nextEpisode();
            return null;
          },
        ),
        _PrevEpisodeIntent: CallbackAction<_PrevEpisodeIntent>(
          onInvoke: (_) {
            _prevEpisode();
            return null;
          },
        ),
      };

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Shortcuts(
        shortcuts: _shortcuts,
        child: Actions(
          actions: _actions,
          child: Focus(
            focusNode: _rootFocusNode,
            autofocus: true,
            onKeyEvent: _onRootKey,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  RepaintBoundary(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _buildVideoArea(),
                      ),
                    ),
                  ),
                  if (_showSubtitle && (_subtitleUrl?.isNotEmpty ?? false))
                    RepaintBoundary(child: _buildSubtitleOverlay()),
                  if (_showControls)
                    RepaintBoundary(child: _buildBottomControls()),
                  if (_showEpisodePanel)
                    RepaintBoundary(child: _buildEpisodePanel()),
                  RepaintBoundary(child: _buildTopInfo()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoArea() {
    switch (_playerState) {
      case _PlayerState.loading:
        return _buildLoading();

      case _PlayerState.error:
        return _buildError();

      case _PlayerState.playing:
      case _PlayerState.paused:
        final ctrl = _controller;

        if (ctrl == null || !ctrl.value.isInitialized) {
          return _buildLoading();
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: ctrl.value.size.width,
                height: ctrl.value.size.height,
                child: VideoPlayer(ctrl),
              ),
            ),
            if (!_isPlaying)
              Container(
                color: Colors.black38,
                child: const Center(
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white70,
                    size: 90,
                  ),
                ),
              ),
          ],
        );
    }
  }

  Widget _buildLoading() {
    return Container(
      color: const Color(0xFF10131A),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF04D2FF),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.title} • Episode $_currentEpisode',
              style: const TextStyle(
                color: Color(0xFF04D2FF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Memuat stream...',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      color: const Color(0xFF10131A),
      child: Center(
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.white38,
                size: 58,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage ?? 'Gagal memuat video',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _tvButton(
                icon: Icons.refresh_rounded,
                label: 'Coba Lagi',
                onTap: () => _loadEpisode(_currentEpisode),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopInfo() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 220),
      top: _showControls || _showEpisodePanel ? 0 : -90,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: !_showControls && !_showEpisodePanel,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: _showControls || _showEpisodePanel ? 1 : 0,
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 34),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.82),
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.tv_rounded,
                  color: Color(0xFF04D2FF),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${widget.title}  •  Episode $_currentEpisode / $_totalEpisodes',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  widget.source.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: FocusScope(
        node: _controlsFocusNode,
        autofocus: true,
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(42, 28, 42, 26),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.95),
                  Colors.black.withOpacity(0.52),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildProgress(),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _tvIconButton(
                      icon: Icons.skip_previous_rounded,
                      onTap: _prevEpisode,
                      enabled: _currentEpisode > 1,
                    ),
                    const SizedBox(width: 14),
                    _tvIconButton(
                      icon: _isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      onTap: _togglePlayPause,
                      isPrimary: true,
                    ),
                    const SizedBox(width: 14),
                    _tvIconButton(
                      icon: Icons.skip_next_rounded,
                      onTap: _nextEpisode,
                      enabled: _currentEpisode < _totalEpisodes,
                    ),
                    const SizedBox(width: 28),
                    _tvButton(
                      icon: Icons.replay_10_rounded,
                      label: '-10s',
                      onTap: () => _seek(-10),
                    ),
                    const SizedBox(width: 10),
                    _tvButton(
                      icon: Icons.forward_10_rounded,
                      label: '+10s',
                      onTap: () => _seek(10),
                    ),
                    const Spacer(),
                    _tvButton(
                      icon: Icons.closed_caption_rounded,
                      label: _showSubtitle ? 'Subtitle ON' : 'Subtitle OFF',
                      onTap: _toggleSubtitle,
                    ),
                    const SizedBox(width: 10),
                    _tvButton(
                      icon: Icons.view_list_rounded,
                      label: 'Episode',
                      onTap: _showEpisodePanelSafe,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            _fmt(_positionSeconds),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 5,
              activeTrackColor: const Color(0xFF04D2FF),
              inactiveTrackColor: Colors.white24,
              thumbColor: Colors.white,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 6,
              ),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: _positionSeconds.clamp(0.0, _durationSeconds),
              max: _durationSeconds,
              onChanged: (value) {
                setState(() {
                  _positionSeconds = value;
                });
              },
              onChangeEnd: (value) {
                _controller?.seekTo(
                  Duration(milliseconds: (value * 1000).round()),
                );
                _resetHideControlsTimer();
              },
            ),
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            _fmt(_durationSeconds),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEpisodePanel() {
    return Align(
      alignment: Alignment.centerRight,
      child: FocusScope(
        node: _episodePanelFocusNode,
        autofocus: true,
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Container(
            width: 330,
            height: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 26, 18, 22),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1117),
              border: const Border(
                left: BorderSide(color: Colors.white12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.65),
                  blurRadius: 24,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Daftar Episode',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    _tvIconButton(
                      icon: Icons.close_rounded,
                      onTap: _closeOverlays,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: GridView.builder(
                    controller: _episodeScrollController,
                    itemCount: _episodes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.25,
                    ),
                    itemBuilder: (context, index) {
                      final episode = _episodes[index];
                      final isCurrent = episode == _currentEpisode;

                      return RepaintBoundary(
                        child: _episodeButton(
                          episode: episode,
                          isCurrent: isCurrent,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _episodeButton({
    required int episode,
    required bool isCurrent,
  }) {
    return Focus(
      autofocus: episode == _currentEpisode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select)) {
          _loadEpisode(episode);
          _closeOverlays();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;

          return GestureDetector(
            onTap: () {
              _loadEpisode(episode);
              _closeOverlays();
            },
            child: AnimatedScale(
              scale: focused ? 1.10 : 1.0,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? const Color(0xFFFF003F)
                      : focused
                          ? Colors.white24
                          : Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: focused
                        ? const Color(0xFF04D2FF)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$episode',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight:
                          focused || isCurrent ? FontWeight.w800 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubtitleOverlay() {
    return Positioned(
      left: 90,
      right: 90,
      bottom: _showControls ? 145 : 50,
      child: IgnorePointer(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.72),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Subtitle tersedia',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _tvIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
    bool enabled = true,
  }) {
    return Focus(
      canRequestFocus: enabled,
      onKeyEvent: (node, event) {
        if (!enabled) return KeyEventResult.ignored;

        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select)) {
          onTap();
          _resetHideControlsTimer();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;

          return GestureDetector(
            onTap: enabled
                ? () {
                    onTap();
                    _resetHideControlsTimer();
                  }
                : null,
            child: AnimatedScale(
              scale: focused ? 1.13 : 1.0,
              duration: const Duration(milliseconds: 120),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: isPrimary ? 54 : 42,
                height: isPrimary ? 54 : 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !enabled
                      ? Colors.white10
                      : isPrimary
                          ? focused
                              ? const Color(0xFF04D2FF)
                              : Colors.white
                          : focused
                              ? Colors.white24
                              : Colors.white10,
                  border: Border.all(
                    color: focused
                        ? const Color(0xFF04D2FF)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  color: !enabled
                      ? Colors.white24
                      : isPrimary
                          ? Colors.black
                          : Colors.white,
                  size: isPrimary ? 32 : 23,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tvButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select)) {
          onTap();
          _resetHideControlsTimer();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;

          return GestureDetector(
            onTap: () {
              onTap();
              _resetHideControlsTimer();
            },
            child: AnimatedScale(
              scale: focused ? 1.08 : 1.0,
              duration: const Duration(milliseconds: 120),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: focused ? Colors.white24 : Colors.white10,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: focused
                        ? const Color(0xFF04D2FF)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color:
                          focused ? const Color(0xFF04D2FF) : Colors.white70,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        color:
                            focused ? const Color(0xFF04D2FF) : Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
