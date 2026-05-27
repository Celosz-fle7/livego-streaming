import 'package:flutter/material.dart';

class TVSportCard extends StatelessWidget {
  final String home;
  final String away;
  final String league;
  final String time;

  const TVSportCard({
    super.key,
    required this.home,
    required this.away,
    required this.league,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            league,
            style: const TextStyle(
              color: Color(0xFF04D2FF),
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '$home vs $away',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
