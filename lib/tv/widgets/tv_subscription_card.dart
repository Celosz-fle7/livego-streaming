import 'package:flutter/material.dart';

class TVSubscriptionCard
    extends StatelessWidget {
  final String name;
  final String price;
  final List<String> features;
  final bool focused;

  const TVSubscriptionCard({
    super.key,
    required this.name,
    required this.price,
    required this.features,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: focused ? 1.04 : 1,
      duration:
          const Duration(milliseconds: 120),
      child: Container(
        width: 320,
        padding:
            const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: focused
              ? Colors.white12
              : Colors.white10,
          borderRadius:
              BorderRadius.circular(22),
          border: Border.all(
            color: focused
                ? const Color(0xFF04D2FF)
                : Colors.white12,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              price,
              style: const TextStyle(
                color: Color(0xFF04D2FF),
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ...features.map(
              (e) => Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color:
                          Color(0xFF04D2FF),
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        e,
                        style:
                            const TextStyle(
                          color:
                              Colors.white70,
                        ),
                      ),
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
