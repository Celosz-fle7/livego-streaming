import 'package:flutter/material.dart';

class TVPlayerAnalyticsPanel
    extends StatelessWidget {
  final int plays;
  final int pauses;
  final int seeks;

  const TVPlayerAnalyticsPanel({
    super.key,
    required this.plays,
    required this.pauses,
    required this.seeks,
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
          row('Plays', plays),
          row('Pauses', pauses),
          row('Seeks', seeks),
        ],
      ),
    );
  }
}
