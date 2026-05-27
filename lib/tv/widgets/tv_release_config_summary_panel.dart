import 'package:flutter/material.dart';

import '../performance/tv_release_config_summary.dart';

class TVReleaseConfigSummaryPanel extends StatelessWidget {
  const TVReleaseConfigSummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final data = TVReleaseConfigSummary.snapshot();

    final rows = data.entries.toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (_, i) {
          final item = rows[i];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.key,
                    style: const TextStyle(color: Colors.white60),
                  ),
                ),
                Text(
                  '${item.value}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
