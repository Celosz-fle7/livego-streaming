import 'package:flutter/material.dart';

class TVHeroBanner extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: 360,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF10131A),
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
              left: 42,
              bottom: 54,
              width: 520,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    synopsis,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [
                      _HeroButton(
                        label: 'Putar',
                        icon: Icons.play_arrow_rounded,
                        primary: true,
                        onTap: onPlay,
                      ),
                      const SizedBox(width: 14),
                      _HeroButton(
                        label: 'Detail',
                        icon: Icons.info_outline_rounded,
                        primary: false,
                        onTap: onDetail,
                      ),
                    ],
                  ),
                ],
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
                  horizontal: 22,
                  vertical: 12,
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
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: primary ? Colors.black : Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        color: primary ? Colors.black : Colors.white,
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
