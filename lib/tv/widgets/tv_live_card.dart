import 'package:flutter/material.dart';

class TVLiveCard extends StatelessWidget {
  final String title;
  final bool focused;

  const TVLiveCard({
    super.key,
    required this.title,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: focused ? 1.06 : 1,
      duration:
          const Duration(milliseconds: 120),
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: focused
                ? const Color(0xFF04D2FF)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                  gradient:
                      LinearGradient(
                    begin:
                        Alignment.topCenter,
                    end: Alignment
                        .bottomCenter,
                    colors: [
                      Colors.white10,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(
                    6,
                  ),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 18,
              child: Text(
                title,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
