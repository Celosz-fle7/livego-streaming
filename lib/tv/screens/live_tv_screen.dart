import 'package:flutter/material.dart';

import '../../core/tv/tv_live_controller.dart';

import '../widgets/tv_live_card.dart';

class LiveTVScreen
    extends StatelessWidget {
  const LiveTVScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final channels =
        TVLiveController.channels;

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
              'Live TV',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                  childAspectRatio: 1.4,
                ),
                itemCount:
                    channels.length,
                itemBuilder: (_, i) {
                  final item =
                      channels[i];

                  return TVLiveCard(
                    title: item.name,
                    focused: false,
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
