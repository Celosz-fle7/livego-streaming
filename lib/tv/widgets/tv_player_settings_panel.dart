import 'package:flutter/material.dart';

class TVPlayerSettingsPanel
    extends StatelessWidget {
  final String quality;
  final bool subtitle;

  const TVPlayerSettingsPanel({
    super.key,
    required this.quality,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding:
          const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min,
        children: [
          const Text(
            'Player Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              const Text(
                'Quality',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text(
                quality,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              const Text(
                'Subtitle',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text(
                subtitle ? 'ON' : 'OFF',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
