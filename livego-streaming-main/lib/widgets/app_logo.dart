// lib/widgets/app_logo.dart
// FIXED: AnimatedBuilder → ListenableBuilder (Flutter 3.22+)

import 'dart:math' as math;
import 'package:flutter/material.dart';

// ==========================================
// 1. LOGO TEXT GERAK (Untuk AppBar Tengah)
// ==========================================
class LiveGoAnimatedText extends StatefulWidget {
  final double fontSize;
  const LiveGoAnimatedText({super.key, this.fontSize = 22.0});

  @override
  State<LiveGoAnimatedText> createState() => _LiveGoAnimatedTextState();
}

class _LiveGoAnimatedTextState extends State<LiveGoAnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ListenableBuilder(
        listenable: _textController,
        builder: (context, child) {
          return ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: const [
                  Color(0xFF04D2FF),
                  Color(0xFF027DFD),
                  Color(0xFF9D4EDD),
                  Color(0xFF04D2FF),
                ],
                stops: [
                  0.0,
                  0.3 + (math.sin(_textController.value * 2 * math.pi) * 0.1),
                  0.7 + (math.cos(_textController.value * 2 * math.pi) * 0.1),
                  1.0,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              'LiveGO',
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 2. LOGO SPLASH / HEADER BANNER
// ==========================================
class LiveGoHeaderBanner extends StatefulWidget {
  final double size;
  const LiveGoHeaderBanner({super.key, this.size = 150.0});

  @override
  State<LiveGoHeaderBanner> createState() => _LiveGoHeaderBannerState();
}

class _LiveGoHeaderBannerState extends State<LiveGoHeaderBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: ListenableBuilder(
              listenable: _bgController,
              builder: (context, child) {
                return CustomPaint(
                  painter: LiquidBackgroundPainter(_bgController.value),
                  size: Size(widget.size, widget.size),
                );
              },
            ),
          ),
          LiveGoAnimatedText(fontSize: widget.size * 0.22),
        ],
      ),
    );
  }
}

// Painter untuk efek ombak cairan
class LiquidBackgroundPainter extends CustomPainter {
  final double animValue;
  LiquidBackgroundPainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    final colors = [
      const Color(0xFF027DFD),
      const Color(0xFF04D2FF),
      const Color(0xFF9D4EDD),
    ];

    for (int i = 0; i < 2; i++) {
      final path = Path();
      final List<Offset> points = [];
      double baseRadius = (size.width * 0.28) + (i * 10);
      double speed = (i + 1) * 2 * math.pi;

      for (int angle = 0; angle <= 360; angle += 10) {
        double rad = angle * math.pi / 180;
        double wave = math.sin((animValue * speed) + (angle * 2 * math.pi / 180)) * (size.width * 0.05);
        double r = baseRadius + wave;

        double x = center.dx + r * math.cos(rad);
        double y = center.dy + r * math.sin(rad);
        points.add(Offset(x, y));
      }

      path.moveTo(points.first.dx, points.first.dy);
      for (var p in points) {
        path.lineTo(p.dx, p.dy);
      }
      path.close();

      paint.shader = RadialGradient(
        center: Alignment(
          math.sin(animValue * 2 * math.pi) * 0.2,
          math.cos(animValue * 2 * math.pi) * 0.2,
        ),
        radius: 0.8,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, size.width * 0.12);
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant LiquidBackgroundPainter oldDelegate) {
    return oldDelegate.animValue != animValue;
  }
}

// ==========================================
// 3. LOGO MINI APPBAR KIRI
// ==========================================
class LiveGoMiniIcon extends StatelessWidget {
  final double size;
  const LiveGoMiniIcon({super.key, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFF04060A),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF04D2FF), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF04D2FF).withOpacity(0.3),
              blurRadius: 8,
            )
          ],
        ),
        child: Center(
          child: Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: size * 0.65,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. AVATAR AKUN
// ==========================================
class LiveGoUserAvatar extends StatelessWidget {
  final double size;
  const LiveGoUserAvatar({super.key, this.size = 64.0});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF04D2FF), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF027DFD).withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: CircleAvatar(
          backgroundColor: const Color(0xFF0D1117),
          child: Icon(
            Icons.play_circle_filled_rounded,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 5. LOGO STATIC
// ==========================================
class LiveGoStaticLogo extends StatelessWidget {
  final double size;
  const LiveGoStaticLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiveGoMiniIcon(size: size),
          const SizedBox(height: 12),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Color(0xFF04D2FF), Color(0xFF027DFD), Color(0xFF9D4EDD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              'LiveGO',
              style: TextStyle(
                fontSize: size * 0.35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
