import 'package:flutter/material.dart';

class TVEpisodeBadge
    extends StatelessWidget {
  final int current;
  final int total;

  const TVEpisodeBadge({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        'EP $current/$total',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
