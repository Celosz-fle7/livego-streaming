import 'package:flutter/material.dart';

class TVLoadingSkeleton extends StatefulWidget {
  const TVLoadingSkeleton({super.key});

  @override
  State<TVLoadingSkeleton> createState() => _TVLoadingSkeletonState();
}

class _TVLoadingSkeletonState extends State<TVLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shine;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..repeat();

    _shine = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _shine,
        builder: (_, __) {
          return ListView(
            padding: const EdgeInsets.only(top: 40, bottom: 60),
            children: [
              _box(width: double.infinity, height: 360, radius: 0),
              const SizedBox(height: 36),
              for (int r = 0; r < 3; r++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: _box(width: 220, height: 26, radius: 8),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    itemCount: 8,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: _box(width: 170, height: 245, radius: 14),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _box({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment(-1 + _shine.value, 0),
          end: Alignment(_shine.value, 0),
          colors: const [
            Color(0xFF111827),
            Color(0xFF1F2937),
            Color(0xFF111827),
          ],
        ),
      ),
    );
  }
}
