import 'dart:ui';
import 'package:flutter/material.dart';

class TVHeroBanner extends StatefulWidget {
  final String title;
  final String image;
  final String synopsis;
  final VoidCallback onPlay;
  final VoidCallback onDetail;

  const TVHeroBanner({
    super.key,
    required this.title,
    required this.image,
    required this.synopsis,
    required this.onPlay,
    required this.onDetail,
  });

  @override
  State<TVHeroBanner> createState() => _TVHeroBannerState();
}

class _TVHeroBannerState extends State<TVHeroBanner>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 1.0,
      end: 1.08,
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
      child: SizedBox(
        height: 420,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [

            AnimatedBuilder(
              animation: _scale,
              builder: (_, child) {
                return Transform.scale(
                  scale: _scale.value,
                  child: child,
                );
              },
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: const Color(0xFF10131A),
                  );
                },
              ),
            ),

            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.3,
                sigmaY: 0.3,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.05),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF070B12),
                    const Color(0xFF070B12).withOpacity(0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF070B12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            Positioned(
              left: 52,
              bottom: 58,
              width: 560,
              child: RepaintBoundary(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      widget.synopsis,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 26),

                    Row(
                      children: [

                        _HeroButton(
                          label: 'Putar',
                          icon: Icons.play_arrow_rounded,
                          primary: true,
                          onTap: widget.onPlay,
                        ),

                        const SizedBox(width: 14),

                        _HeroButton(
                          label: 'Detail',
                          icon: Icons.info_outline_rounded,
                          primary: false,
                          onTap: widget.onDetail,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool primary;
  final VoidCallback onTap;

  const _HeroButton({
    required this.label,
    required this.icon,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: false,
      child: Builder(
        builder: (context) {

          final focused = Focus.of(context).hasFocus;

          return GestureDetector(
            onTap: onTap,
            child: AnimatedScale(
              scale: focused ? 1.08 : 1.0,
              duration: const Duration(milliseconds: 120),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: primary
                      ? Colors.white
                      : focused
                          ? Colors.white24
                          : Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: focused
                        ? const Color(0xFF04D2FF)
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: focused
                      ? [
                          const BoxShadow(
                            color: Color(0xFF04D2FF),
                            blurRadius: 14,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [

                    Icon(
                      icon,
                      color: primary
                          ? Colors.black
                          : Colors.white,
                      size: 22,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      label,
                      style: TextStyle(
                        color: primary
                            ? Colors.black
                            : Colors.white,
                        fontSize: 15,
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
