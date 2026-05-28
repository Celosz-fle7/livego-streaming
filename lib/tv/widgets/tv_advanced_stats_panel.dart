import 'package:flutter/material.dart';

class TVAdvancedStatsPanel
    extends StatelessWidget {
  final int sessions;
  final int crashes;
  final int retries;

  const TVAdvancedStatsPanel({
    super.key,
    required this.sessions,
    required this.crashes,
    required this.retries,
  });

  Widget row(
    String text,
    int value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          Text(
            '$value',
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          row('Sessions', sessions),
          row('Crashes', crashes),
          row('Retries', retries),
        ],
      ),
    );
  }
}
