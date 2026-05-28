import 'package:flutter/material.dart';

class TVPreferencePanel
    extends StatelessWidget {
  final bool autoplay;
  final bool subtitles;
  final String quality;

  const TVPreferencePanel({
    super.key,
    required this.autoplay,
    required this.subtitles,
    required this.quality,
  });

  Widget _row(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          _row(
            'Autoplay',
            autoplay ? 'ON' : 'OFF',
          ),
          _row(
            'Subtitles',
            subtitles ? 'ON' : 'OFF',
          ),
          _row(
            'Quality',
            quality,
          ),
        ],
      ),
    );
  }
}
