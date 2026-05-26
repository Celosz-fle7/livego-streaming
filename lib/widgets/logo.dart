// lib/widgets/logo.dart
// FIXED: AnimatedBuilder → ListenableBuilder (Flutter 3.22+)

import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==========================================
// LOGO ROBOT COPILOT + TULISAN LIVEGO
// ==========================================
class LiveGoRobotLogo extends StatelessWidget {
  final double size;
  
  const LiveGoRobotLogo({super.key, this.size = 80});
  
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: CopilotRobotLogoPainter(),
              size: Size(size, size),
            ),
          ),
          const SizedBox(height: 12),
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Color(0xFF04D2FF), Color(0xFF027DFD), Color(0xFF9D4EDD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
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

// ==========================================
// LOGO ANIMATED (untuk splash screen)
// ==========================================
class LiveGoAnimatedLogo extends StatefulWidget {
  final double size;
  final VoidCallback? onAnimationComplete;

  const LiveGoAnimatedLogo({
    super.key,
    this.size = 120,
    this.onAnimationComplete,
  });

  @override
  State<LiveGoAnimatedLogo> createState() => _LiveGoAnimatedLogoState();
}

class _LiveGoAnimatedLogoState extends State<LiveGoAnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    
    _controller.forward().then((_) {
      widget.onAnimationComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: LiveGoRobotLogo(size: widget.size),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// PAINTER ROBOT COPILOT
// ==========================================
class CopilotRobotLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final w = size.width;
    final h = size.height;
    
    paint.color = const Color(0xFF027DFD);
    final helmPath = Path()
      ..moveTo(w * 0.1, h * 0.6)
      ..cubicTo(w * 0.1, h * 0.1, w * 0.9, h * 0.1, w * 0.9, h * 0.6)
      ..lineTo(w * 0.8, h * 0.85)
      ..lineTo(w * 0.2, h * 0.85)
      ..close();
    canvas.drawPath(helmPath, paint);
    
    paint.color = const Color(0xFF04060A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.2, h * 0.35, w * 0.6, h * 0.35),
        const Radius.circular(8),
      ),
      paint,
    );
    
    paint.color = const Color(0xFF04D2FF);
    canvas.drawCircle(Offset(w * 0.38, h * 0.52), w * 0.08, paint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.52), w * 0.08, paint);
    
    paint.color = const Color(0xFF9D4EDD);
    canvas.drawCircle(Offset(w * 0.08, h * 0.55), w * 0.08, paint);
    canvas.drawCircle(Offset(w * 0.92, h * 0.55), w * 0.08, paint);
    
    paint.color = const Color(0xFF027DFD);
    final bodyPath = Path()
      ..moveTo(w * 0.3, h * 0.85)
      ..lineTo(w * 0.7, h * 0.85)
      ..lineTo(w * 0.65, h * 0.95)
      ..lineTo(w * 0.35, h * 0.95)
      ..close();
    canvas.drawPath(bodyPath, paint);
    
    paint.color = const Color(0xFF04D2FF);
    canvas.drawCircle(Offset(w * 0.5, h * 0.9), w * 0.05, paint);
    
    final glowPaint = Paint()
      ..color = const Color(0xFF04D2FF).withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(w * 0.38, h * 0.52), w * 0.12, glowPaint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.52), w * 0.12, glowPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// LOGO MINI UNTUK APPBAR (tanpa teks)
// ==========================================
class LiveGoMiniLogo extends StatelessWidget {
  final double size;
  
  const LiveGoMiniLogo({super.key, this.size = 32});
  
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: CopilotRobotMiniPainter(),
          size: Size(size, size),
        ),
      ),
    );
  }
}

class CopilotRobotMiniPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final w = size.width;
    final h = size.height;
    
    paint.color = const Color(0xFF027DFD);
    final helmPath = Path()
      ..moveTo(w * 0.15, h * 0.6)
      ..cubicTo(w * 0.15, h * 0.15, w * 0.85, h * 0.15, w * 0.85, h * 0.6)
      ..lineTo(w * 0.75, h * 0.8)
      ..lineTo(w * 0.25, h * 0.8)
      ..close();
    canvas.drawPath(helmPath, paint);
    
    paint.color = const Color(0xFF04060A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.25, h * 0.4, w * 0.5, h * 0.3),
        const Radius.circular(6),
      ),
      paint,
    );
    
    paint.color = const Color(0xFF04D2FF);
    canvas.drawCircle(Offset(w * 0.42, h * 0.55), w * 0.07, paint);
    canvas.drawCircle(Offset(w * 0.58, h * 0.55), w * 0.07, paint);
    
    paint.color = const Color(0xFF9D4EDD);
    canvas.drawCircle(Offset(w * 0.1, h * 0.55), w * 0.08, paint);
    canvas.drawCircle(Offset(w * 0.9, h * 0.55), w * 0.08, paint);
    
    final glowPaint = Paint()
      ..color = const Color(0xFF04D2FF).withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawCircle(Offset(w * 0.42, h * 0.55), w * 0.1, glowPaint);
    canvas.drawCircle(Offset(w * 0.58, h * 0.55), w * 0.1, glowPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// LOGO DENGAN TEKS (untuk splash/booting)
// ==========================================
class LiveGoFullLogo extends StatelessWidget {
  final double size;
  
  const LiveGoFullLogo({super.key, this.size = 100});
  
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiveGoRobotLogo(size: size),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF04D2FF), Color(0xFF027DFD), Color(0xFF9D4EDD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF04D2FF).withOpacity(0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Text(
              'PREMIUM',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔥 Helper extension
extension LiveGoThemeHelper on BuildContext {
  LiveGOCopilotThemeType get livego => LiveGOCopilotThemeType(this);
}

class LiveGOCopilotThemeType {
  final BuildContext context;
  LiveGOCopilotThemeType(this.context);
  
  Color get cyan => const Color(0xFF04D2FF);
  Color get blue => const Color(0xFF027DFD);
  Color get purple => const Color(0xFF9D4EDD);
  
  LinearGradient get premiumGradient => const LinearGradient(
    colors: [Color(0xFF04D2FF), Color(0xFF027DFD), Color(0xFF9D4EDD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
