import 'package:flutter/material.dart';

import '../../core/tv/tv_sports_controller.dart';

import '../widgets/tv_sport_card.dart';

class TVSportsScreen
    extends StatelessWidget {
  const TVSportsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items =
        TVSportsController.matches;

    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: Padding(
        padding:
            const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Live Sports',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: ListView.separated(
                scrollDirection:
                    Axis.horizontal,
                itemCount: items.length,
                separatorBuilder:
                    (_, __) =>
                        const SizedBox(
                  width: 22,
                ),
                itemBuilder: (_, i) {
                  final item =
                      items[i];

                  return TVSportCard(
                    home: item.home,
                    away: item.away,
                    league: item.league,
                    time: item.time,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
