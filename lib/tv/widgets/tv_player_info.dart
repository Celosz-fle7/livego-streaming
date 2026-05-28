import 'package:flutter/material.dart';

class TVPlayerInfo extends StatelessWidget {
  final String quality;
  final bool subtitle;

  const TVPlayerInfo({
    super.key,
    required this.quality,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius:
                BorderRadius.circular(6),
          ),
          child: Text(
            quality,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: subtitle
                ? const Color(
                    0xFF04D2FF,
                  )
                : Colors.white12,
            borderRadius:
                BorderRadius.circular(6),
          ),
          child: Text(
            subtitle
                ? 'SUBTITLE'
                : 'NO SUB',
            style: TextStyle(
              color: subtitle
                  ? Colors.black
                  : Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
