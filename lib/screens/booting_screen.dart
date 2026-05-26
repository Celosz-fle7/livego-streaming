// lib/screens/booting_screen.dart
// FIXED: TV detection + ListenableBuilder

import 'dart:math' as math;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../services/drama_repository.dart';
import '../tv/screens/home_screen.dart';
import '../mobile/screens/main_wrapper.dart';

class LiveGoBootingScreen extends StatefulWidget {
  const LiveGoBootingScreen({super.key});
  @override
  State<LiveGoBootingScreen> createState() => _LiveGoBootingScreenState();
}

class _LiveGoBootingScreenState extends State<LiveGoBootingScreen> with TickerProviderStateMixin {
  late AnimationController _masterController;
  late AnimationController _robotController;
  late AnimationController _neonController;

  double _progress = 0.0;
  double _oldProgress = 0.0;
  String _loadingText = 'Memulai LiveGO...';
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _masterController = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
    _robotController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500))..repeat(reverse: true);
    _neonController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400))..repeat(reverse: true);
    _runBootSequence();
  }

  @override
  void dispose() {
    _masterController.dispose(); _robotController.dispose(); _neonController.dispose();
    super.dispose();
  }

  // 🔥 FIX: Deteksi TV lebih robust
  bool _isTV(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final ratio = width / height;

    // TV biasanya: lebar > 900 DAN rasio > 1.3 (landscape) DAN bukan Android/iOS mobile
    if (Platform.isAndroid) {
      // Android TV biasanya punya lebar > 900 dan rasio landscape
      return width > 900 && ratio > 1.3;
    }
    // Fallback: cek lebar saja
    return width > 900;
  }

  Future<void> _runBootSequence() async {
    final startTime = DateTime.now();
    _setProgress(0.1, 'Memuat kategori...');
    try { await DramaRepository.getCategories(); } catch (_) { _hasError = true; }
    _setProgress(0.4, 'Memuat konten trending...');
    try { await DramaRepository.getTrending(Platforms.freereels.id); } catch (_) {}
    _setProgress(0.75, 'Memuat sumber data...');
    try { await DramaRepository.getTrending(Platforms.dramawave.id); } catch (_) {}
    _setProgress(1.0, _hasError ? 'Mode offline...' : 'Siap!');
    final elapsed = DateTime.now().difference(startTime).inMilliseconds;
    if (elapsed < 2500) await Future.delayed(Duration(milliseconds: 2500 - elapsed));
    if (!mounted) return;
    final isTV = _isTV(context);
    Navigator.pushReplacement(context, PageRouteBuilder(
      pageBuilder: (_, __, ___) => isTV ? const TVHomeScreen() : const MobileMainWrapper(),
      transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 600),
    ));
  }

  void _setProgress(double value, String text) {
    if (!mounted) return;
    setState(() { _oldProgress = _progress; _progress = value; _loadingText = text; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04060A),
      body: RepaintBoundary(child: Stack(children: [
        Positioned.fill(
          child: ListenableBuilder(listenable: _masterController,
            builder: (_, __) => RepaintBoundary(child: CustomPaint(painter: _OptimizedBackgroundPainter(animValue: _masterController.value), isComplex: true, willChange: false)))),
        SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final isTV = _isTV(context);
          return Center(child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: isTV ? 60 : 40),
            _buildBranding(isTV ? 220 : 180),
            SizedBox(height: isTV ? 50 : 30),
            Container(constraints: BoxConstraints(maxWidth: isTV ? 700 : double.infinity),
              padding: EdgeInsets.symmetric(horizontal: isTV ? 100 : 24),
              child: _buildLoadingSection(isTv: isTV)),
            SizedBox(height: isTV ? 60 : 40),
          ])));
        })),
      ])),
    );
  }

  Widget _buildBranding(double maxWidth) {
    return RepaintBoundary(child: ListenableBuilder(listenable: Listenable.merge([_masterController, _neonController]),
      builder: (_, __) => Column(mainAxisSize: MainAxisSize.min, children: [
        Transform.scale(scale: 1.0 + math.sin(_masterController.value * 2 * math.pi) * 0.015,
          child: ShaderMask(blendMode: BlendMode.srcIn,
            shaderCallback: (b) => LinearGradient(colors: const [Color(0xFFFFFFFF), Color(0xFF04D2FF), Color(0xFF027DFD), Color(0xFFFFFFFF)],
              stops: [0.0, 0.2 + math.sin(_masterController.value * 2 * math.pi) * 0.1, 0.6 + math.cos(_masterController.value * 2 * math.pi) * 0.1, 1.0],
              begin: Alignment.topLeft, end: Alignment.bottomRight).createShader(b),
            child: Text('LiveGO', style: TextStyle(fontSize: maxWidth * 0.24, fontWeight: FontWeight.bold, letterSpacing: -1.0,
              shadows: [Shadow(color: const Color(0xFF04D2FF).withOpacity(0.4), blurRadius: 25)])))),
        const SizedBox(height: 4),
        ShaderMask(blendMode: BlendMode.srcIn,
          shaderCallback: (b) => LinearGradient(
            colors: [const Color(0xFF9D4EDD).withOpacity((_neonController.value > 0.7 || _neonController.value < 0.2) ? 1.0 : 0.75), const Color(0xFFFF007F).withOpacity((_neonController.value > 0.7 || _neonController.value < 0.2) ? 1.0 : 0.75)]).createShader(b),
          child: Text('P R E M I U M', style: TextStyle(fontSize: maxWidth * 0.055, fontWeight: FontWeight.w900, letterSpacing: 6,
            shadows: [Shadow(color: const Color(0xFFFF007F).withOpacity(0.6), blurRadius: _neonController.value * 12)]))),
      ])));
  }

  Widget _buildLoadingSection({required bool isTv}) {
    return RepaintBoundary(child: Column(mainAxisSize: MainAxisSize.min, children: [
      ListenableBuilder(listenable: _robotController, builder: (_, __) {
        final curved = CurvedAnimation(parent: _robotController, curve: Curves.easeInOutSine).value;
        final bounce = math.sin(curved * math.pi) * 10;
        final screenW = MediaQuery.of(context).size.width;
        final allocW = isTv ? screenW * 0.5 : screenW - 48;
        final leftMargin = (allocW * _progress).clamp(20.0, allocW - 30);
        return Container(margin: EdgeInsets.only(bottom: 14, left: leftMargin - 20), transform: Matrix4.translationValues(0, -bounce, 0),
          child: RepaintBoundary(child: CustomPaint(size: Size(isTv ? 56 : 42, isTv ? 48 : 36), painter: const _OptimizedRobotPainter(), isComplex: true, willChange: false)));
      }),
      Container(padding: EdgeInsets.all(isTv ? 28 : 22),
        decoration: BoxDecoration(color: const Color(0xFF0D1117).withOpacity(0.85), borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF21262D), width: 1.2),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 30, offset: const Offset(0, 15))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ListenableBuilder(listenable: _masterController, builder: (_, __) {
              final op = 0.5 + math.sin(_masterController.value * 2 * math.pi).abs() * 0.5;
              return Text(_loadingText, style: TextStyle(color: Colors.white.withOpacity(op), fontSize: isTv ? 18 : 14, fontWeight: FontWeight.w500));
            }),
            Text('${(_progress * 100).toInt()}%', style: TextStyle(color: const Color(0xFF04D2FF), fontSize: isTv ? 18 : 14, fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: isTv ? 18 : 14),
          ClipRRect(borderRadius: BorderRadius.circular(8), child: Stack(alignment: Alignment.centerLeft, children: [
            Container(height: isTv ? 14 : 10, color: const Color(0xFF161B22)),
            TweenAnimationBuilder<double>(tween: Tween<double>(begin: _oldProgress, end: _progress), duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad,
              builder: (_, value, __) => LayoutBuilder(builder: (_, c) {
                final bw = c.maxWidth * value;
                return Stack(clipBehavior: Clip.none, children: [
                  Container(width: bw, height: isTv ? 14 : 10, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF9D4EDD), Color(0xFF027DFD), Color(0xFF04D2FF)]))),
                  Positioned(left: bw - 6, top: isTv ? 0 : -2, child: Container(width: isTv ? 18 : 14, height: isTv ? 18 : 14,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Color(0xFF04D2FF), blurRadius: 10, spreadRadius: 3)]))),
                ]);
              })),
          ])),
          SizedBox(height: isTv ? 16 : 12),
          Text(_hasError ? 'Tidak ada koneksi. Melanjutkan dengan data cache.' : 'Source, kategori pertama, dan konten awal dimuat dulu sebelum LiveGO dibuka.',
            style: TextStyle(color: _hasError ? Colors.orange.withOpacity(0.7) : Colors.white38, fontSize: isTv ? 13 : 11, height: 1.4, letterSpacing: 0.2)),
        ])),
    ]));
  }
}

class _OptimizedBackgroundPainter extends CustomPainter {
  final double animValue;
  const _OptimizedBackgroundPainter({required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final wx = math.sin(animValue * 2 * math.pi) * (size.width * 0.12);
    final wy = math.cos(animValue * 2 * math.pi) * (size.height * 0.06);
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    paint.shader = RadialGradient(center: Alignment(-1.0 + (wx / size.width), -0.7 + (wy / size.height)), radius: 1.4,
      colors: [const Color(0xFF9D4EDD).withOpacity(0.45), const Color(0xFF027DFD).withOpacity(0.15), Colors.transparent])
      .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawCircle(Offset(0, size.height * 0.15), size.width * 0.6, paint);
    canvas.restore();
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    paint.shader = RadialGradient(center: Alignment(1.1 - (wx / size.width), 1.1 - (wy / size.height)), radius: 1.1,
      colors: [const Color(0xFF04D2FF).withOpacity(0.35), Colors.transparent])
      .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawCircle(Offset(size.width, size.height), size.width * 0.5, paint);
    canvas.restore();
    final gp = Paint()..color = const Color(0xFF21262D).withOpacity(0.12)..style = PaintingStyle.stroke..strokeWidth = 1.0;
    final gh = size.height * 0.65;
    for (int i = 0; i <= 14; i++) { final r = i / 14; final sx = size.width * r; final ex = (size.width * 0.5) + (sx - size.width * 0.5) * 2.2; canvas.drawLine(Offset(sx, gh), Offset(ex, size.height), gp); }
    for (int i = 0; i < 8; i++) { final p = i / 8; final y = gh + (size.height - gh) * math.pow(p, 1.8); canvas.drawLine(Offset(0, y.toDouble()), Offset(size.width, y.toDouble()), gp); }
  }

  @override
  bool shouldRepaint(covariant _OptimizedBackgroundPainter o) => o.animValue != animValue;
}

class _OptimizedRobotPainter extends CustomPainter {
  const _OptimizedRobotPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill; final w = size.width; final h = size.height;
    p.color = const Color(0xFF027DFD);
    canvas.drawPath(Path()..moveTo(w * 0.1, h * 0.6)..cubicTo(w * 0.1, h * 0.1, w * 0.9, h * 0.1, w * 0.9, h * 0.6)..lineTo(w * 0.8, h * 0.9)..lineTo(w * 0.2, h * 0.9)..close(), p);
    p.color = const Color(0xFF04060A);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.22, h * 0.35, w * 0.56, h * 0.35), const Radius.circular(8)), p);
    p.color = const Color(0xFF04D2FF);
    canvas.drawCircle(Offset(w * 0.38, h * 0.5), w * 0.08, p); canvas.drawCircle(Offset(w * 0.62, h * 0.5), w * 0.08, p);
    p.color = const Color(0xFF9D4EDD);
    canvas.drawCircle(Offset(w * 0.08, h * 0.55), w * 0.08, p); canvas.drawCircle(Offset(w * 0.92, h * 0.55), w * 0.08, p);
  }
  @override
  bool shouldRepaint(covariant _OptimizedRobotPainter o) => false;
}