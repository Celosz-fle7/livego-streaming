import 'package:flutter/material.dart';

import 'tv_quality_chip.dart';
import 'tv_subtitle_chip.dart';

class TVPlayerInfoPanel
    extends StatelessWidget {
  final String quality;
  final bool subtitle;

  const TVPlayerInfoPanel({
    super.key,
    required this.quality,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TVQualityChip(
          quality: quality,
        ),
        const SizedBox(width: 12),
        TVSubtitleChip(
          enabled: subtitle,
        ),
      ],
    );
  }
}
