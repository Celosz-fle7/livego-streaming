// lib/mobile/screens/player_screen.dart
// FINAL - FIXED

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../services/drama_repository.dart';
import '../../database/database_helper.dart';

class MobilePlayerScreen extends StatefulWidget {
  final String id, source, title;
  const MobilePlayerScreen({super.key, required this.id, required this.source, required this.title});
  @override
  State<MobilePlayerScreen> createState() => _MobilePlayerScreenState();
}

class _MobilePlayerScreenState extends State<MobilePlayerScreen> {
  VideoPlayerController? _controller;
  bool _isPlaying = true;
  bool _hasVideoError = false;
  final List<String> _qualities = ['Auto', '380p', '480p', '560p', '720p', '1080p'];
  int _qualityIndex = 0;
  String _selectedQuality = 'Auto';
  bool _isFullPortrait = false;
  bool _isLandscape = false;
  bool _showControls = true;
  Timer? _controlsTimer;
  int _currentEpisode = 1;
  int _totalEpisodes = 1;
  Map<String, dynamic>? _detail;
  double _currentSliderValue = 0.0;
  double _totalDuration = 1.0;
  bool _isBuffering = false;
  Timer? _bufferDebounce;
  int _retryCount = 0;
  static const int _maxRetry = 3;
  bool _showSeekIndicator = false;
  bool _isForwardSeek = true;
  Timer? _seekTimer;
  double _seekDelta = 0.0;
  List<int> _epNums = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _loadDetail();
    _resetControlsTimer();
  }

  @override
  void dispose() {
    _controller?.removeListener(_onPlayerUpdate);
    _controller?.dispose();
    _controlsTimer?.cancel();
    _bufferDebounce?.cancel();
    _seekTimer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  Future<void> _loadDetail() async {
    final detail = await DramaRepository.getDetail(widget.id, widget.source);
    if (!mounted) return;
    int eps = 1;
    if (detail != null) {
      _detail = detail;
      eps = detail['total_episodes'] ?? detail['total_chapter'] ?? detail['totalEpisode'] ?? 1;
      eps = eps is int ? eps : int.tryParse(eps.toString()) ?? 1;
    }
    setState(() {
      _totalEpisodes = eps;
      _epNums = List.generate(eps, (i) => i + 1);
    });
    _loadEpisode(1);
  }

  Future<void> _loadEpisode(int ep) async {
    if (!mounted) return;
    _retryCount = 0;
    setState(() {
      _hasVideoError = false;
      _isPlaying = false;
      _isBuffering = true;
    });
    final oldCtrl = _controller;
    _controller?.removeListener(_onPlayerUpdate);
    _controller = null;
    await oldCtrl?.dispose();
    final data = await DramaRepository.getVideo(
      widget.id,
      widget.source,
      episode: ep,
    );
    if (!mounted) return;
    if (data == null) {
      _handleLoadError(ep);
      return;
    }
    final url = (data['video_url'] ?? '').toString();
    if (url.isEmpty) {
      _handleLoadError(ep);
      return;
    }
    final ctrl = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller = ctrl;
    try {
      await ctrl.initialize();
      if (!mounted || _controller != ctrl) {
        ctrl.dispose();
        return;
      }
      _retryCount = 0;
      ctrl.addListener(_onPlayerUpdate);
      setState(() {
        _currentEpisode = ep;
        _totalDuration = ctrl.value.duration.inSeconds.toDouble().clamp(1, 99999);
        _currentSliderValue = 0;
        _isPlaying = true;
        _hasVideoError = false;
        _isBuffering = false;
      });
      ctrl.play();
      DatabaseHelper().addToHistory(
        dramaId: widget.id,
        dramaTitle: widget.title,
        dramaPoster: _detail?['cover'] ?? '',
        platform: widget.source,
        episode: ep,
      );
    } catch (e) {
      _handleLoadError(ep);
    }
  }

  void _handleLoadError(int ep) {
    if (_retryCount < _maxRetry) {
      _retryCount++;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) _loadEpisode(ep);
      });
      if (mounted) setState(() => _isBuffering = true);
    } else {
      if (mounted) setState(() {
        _hasVideoError = true;
        _isBuffering = false;
      });
    }
  }

  void _onPlayerUpdate() {
    if (!mounted || _controller == null) return;
    final pos = _controller!.value.position.inSeconds.toDouble();
    final dur = _controller!.value.duration.inSeconds.toDouble();
    final playing = _controller!.value.isPlaying;
    final buffering = _controller!.value.isBuffering;
    setState(() {
      _currentSliderValue = pos;
      _totalDuration = dur.clamp(1, 99999);
      _isPlaying = playing;
    });
    if (buffering != _isBuffering) {
      _bufferDebounce?.cancel();
      if (buffering) {
        _bufferDebounce = Timer(const Duration(milliseconds: 500), () {
          if (mounted && _controller?.value.isBuffering == true) {
            setState(() => _isBuffering = true);
          }
        });
      } else {
        setState(() => _isBuffering = false);
      }
    }
    if (pos >= dur && dur > 0 && _currentEpisode < _totalEpisodes) {
      _goToEpisode(_currentEpisode + 1);
    }
  }

  void _goToEpisode(int ep) {
    if (ep < 1 || ep > _totalEpisodes || ep == _currentEpisode) return;
    setState(() {
      _currentEpisode = ep;
      _currentSliderValue = 0;
      _showControls = true;
    });
    _loadEpisode(ep);
    _resetControlsTimer();
  }

  void _seek(double delta) {
    final newPos = (_currentSliderValue + delta).clamp(0.0, _totalDuration);
    _controller?.seekTo(Duration(seconds: newPos.toInt()));
    setState(() {
      _currentSliderValue = newPos;
      _showSeekIndicator = true;
      _isForwardSeek = delta > 0;
      _seekDelta = delta.abs();
    });
    _seekTimer?.cancel();
    _seekTimer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _showSeekIndicator = false);
    });
    _resetControlsTimer();
  }

  void _cycleQuality() {
    _qualityIndex = (_qualityIndex + 1) % _qualities.length;
    setState(() => _selectedQuality = _qualities[_qualityIndex]);
    _loadEpisode(_currentEpisode);
  }

  void _toggleRotation() {
    setState(() => _isLandscape = !_isLandscape);
    if (_isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    _resetControlsTimer();
  }

  void _toggleFullPortrait() {
    if (_isLandscape) return;
    setState(() => _isFullPortrait = !_isFullPortrait);
    if (_isFullPortrait) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
    _resetControlsTimer();
  }

  void _resetControlsTimer() {
    _controlsTimer?.cancel();
    if (!_showControls) setState(() => _showControls = true);
    _controlsTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && _showControls) setState(() => _showControls = false);
    });
  }

  void _toggleControlsOverlay() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _resetControlsTimer();
  }

  void _downloadEpisode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⚠️ Fitur unduh belum tersedia'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
    _resetControlsTimer();
  }

  String _fmt(double s) {
    final m = (s / 60).floor();
    final ss = (s % 60).toInt();
    return '$m:${ss.toString().padLeft(2, '0')}';
  }

  void _showEpisodeSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Episode', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: _epNums.length,
                itemBuilder: (context, index) {
                  final ep = _epNums[index];
                  final isCurrent = ep == _currentEpisode;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _goToEpisode(ep);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCurrent ? const Color(0xFF04D2FF) : const Color(0xFF2A2A3E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        ep.toString(),
                        style: TextStyle(
                          color: isCurrent ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pengaturan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Kualitas Video', style: TextStyle(color: Colors.white)),
              trailing: DropdownButton<String>(
                value: _selectedQuality,
                dropdownColor: const Color(0xFF2A2A3E),
                items: _qualities.map((q) => DropdownMenuItem(value: q, child: Text(q, style: const TextStyle(color: Colors.white)))).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedQuality = value);
                    _loadEpisode(_currentEpisode);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Rotasi Layar', style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: _isLandscape,
                onChanged: (val) {
                  _toggleRotation();
                  Navigator.pop(context);
                },
                activeColor: const Color(0xFF04D2FF),
              ),
            ),
            ListTile(
              title: const Text('Mode Layar Penuh', style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: _isFullPortrait && !_isLandscape,
                onChanged: (val) {
                  _toggleFullPortrait();
                  Navigator.pop(context);
                },
                activeColor: const Color(0xFF04D2FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_showControls) {
          // Controls sedang tampil → sembunyikan dulu
          setState(() => _showControls = false);
          _controlsTimer?.cancel();
        } else {
          // Controls sudah tersembunyi → keluar dari player
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: _toggleControlsOverlay,
          onDoubleTapDown: (d) {
            final sw = MediaQuery.of(context).size.width;
            if (d.globalPosition.dx < sw / 2) {
              _seek(-10);
            } else {
              _seek(10);
            }
          },
          child: Stack(
            children: [
              RepaintBoundary(child: _buildVideoArea()),
              if (_showControls && !_isBuffering) _buildCenterNav(),
              if (_showSeekIndicator) RepaintBoundary(child: _buildSeekOverlay()),
              if (_isBuffering) const Center(child: CircularProgressIndicator(color: Color(0xFF04D2FF))),
              RepaintBoundary(child: _buildTopBar()),
              RepaintBoundary(child: _buildBottomBar()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoArea() {
    if (_isFullPortrait && !_isLandscape) {
      return Positioned.fill(child: _buildVideoContent());
    }
    return Center(child: _buildVideoContent());
  }

  Widget _buildVideoContent() {
    if (_controller != null && _controller!.value.isInitialized) {
      return FittedBox(
        fit: _isFullPortrait && !_isLandscape ? BoxFit.cover : BoxFit.contain,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      );
    }
    if (_hasVideoError) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.white38, size: 40),
              const SizedBox(height: 10),
              const Text('Gagal memuat video', style: TextStyle(color: Colors.white38, fontSize: 13)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _loadEpisode(_currentEpisode),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF04D2FF)),
                  ),
                  child: const Text('Coba Lagi', style: TextStyle(color: Color(0xFF04D2FF), fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      color: Colors.black,
      child: const Center(child: CircularProgressIndicator(color: Color(0xFF04D2FF))),
    );
  }

  Widget _buildCenterNav() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _cnb(Icons.skip_previous, _currentEpisode > 1, () => _goToEpisode(_currentEpisode - 1)),
          const SizedBox(width: 30),
          GestureDetector(
            onTap: () {
              setState(() => _isPlaying = !_isPlaying);
              _isPlaying ? _controller?.play() : _controller?.pause();
              _resetControlsTimer();
            },
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white30, width: 1.5),
              ),
              child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 35),
            ),
          ),
          const SizedBox(width: 30),
          _cnb(Icons.skip_next, _currentEpisode < _totalEpisodes, () => _goToEpisode(_currentEpisode + 1)),
        ],
      ),
    );
  }

  Widget _cnb(IconData i, bool e, VoidCallback t) {
    return GestureDetector(
      onTap: e
          ? () {
              _resetControlsTimer();
              t();
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: e ? Colors.black38 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(i, color: e ? Colors.white70 : Colors.white12, size: 28),
      ),
    );
  }

  Widget _buildSeekOverlay() {
    return Positioned(
      left: _isForwardSeek ? null : 0,
      right: _isForwardSeek ? 0 : null,
      top: 0,
      bottom: 0,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: _isForwardSeek ? Alignment.centerRight : Alignment.centerLeft,
            end: _isForwardSeek ? Alignment.centerLeft : Alignment.centerRight,
            colors: [Colors.white.withOpacity(0.15), Colors.transparent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_isForwardSeek ? Icons.fast_forward_rounded : Icons.fast_rewind_rounded, color: Colors.white, size: 36),
              const SizedBox(height: 4),
              Text('${_seekDelta.toInt()}s', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      top: _showControls ? 0 : -100,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _showControls ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: 90,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 4, right: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.8), Colors.transparent],
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  '${widget.title} • Eps $_currentEpisode',
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      bottom: _showControls ? 0 : -200,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _showControls ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.9), Colors.transparent],
            ),
          ),
          padding: EdgeInsets.only(
            bottom: _isLandscape ? 15 : MediaQuery.of(context).padding.bottom + 20,
            top: 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProgressBar(),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _buildShortcutButton(
                      icon: Icons.list_rounded,
                      label: 'Eps',
                      onTap: () {
                        _controlsTimer?.cancel();
                        _showEpisodeSheet(context);
                      },
                    ),
                    const SizedBox(width: 8),
                    _buildShortcutButton(icon: Icons.download, label: 'Unduh', onTap: _downloadEpisode),
                    const SizedBox(width: 8),
                    Expanded(child: _buildSettingsPanel()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsPanel() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.settings, color: Colors.white, size: 18),
            onPressed: () => _showSettingsSheet(context),
          ),
          GestureDetector(
            onTap: () {
              _cycleQuality();
              _resetControlsTimer();
            },
            child: Text(_selectedQuality, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          GestureDetector(
            onTap: _toggleRotation,
            child: Icon(
              Icons.screen_rotation,
              color: _isLandscape ? const Color(0xFF04D2FF) : Colors.white,
              size: 16,
            ),
          ),
          GestureDetector(
            onTap: _toggleFullPortrait,
            child: Icon(
              _isFullPortrait && !_isLandscape ? Icons.fullscreen_exit : Icons.fullscreen,
              color: _isLandscape ? Colors.white24 : (_isFullPortrait ? const Color(0xFF04D2FF) : Colors.white),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(_fmt(_currentSliderValue), style: const TextStyle(color: Colors.white60, fontSize: 11)),
          Expanded(
            child: SliderTheme(
              data: const SliderThemeData(
                trackHeight: 3,
                activeTrackColor: Color(0xFF04D2FF),
                inactiveTrackColor: Colors.white24,
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
              ),
              child: Slider(
                value: _currentSliderValue.clamp(0, _totalDuration),
                max: _totalDuration,
                onChanged: (v) {
                  setState(() => _currentSliderValue = v);
                  _controller?.seekTo(Duration(seconds: v.toInt()));
                  _resetControlsTimer();
                },
                onChangeEnd: (v) {
                  _controller?.seekTo(Duration(seconds: v.toInt()));
                  _resetControlsTimer();
                },
              ),
            ),
          ),
          Text(_fmt(_totalDuration), style: const TextStyle(color: Colors.white60, fontSize: 11)),
        ],
      ),
    );
  }
}