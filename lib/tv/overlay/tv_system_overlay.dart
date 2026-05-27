import 'package:flutter/material.dart';

import '../live/tv_live_status_engine.dart';

class TVSystemOverlay
    extends StatelessWidget {

  const TVSystemOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
      left: 20,
      bottom: 20,

      child: Container(
        padding:
            const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius:
              BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'STATE: ${TVLiveStatusEngine.state}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'USERS: ${TVLiveStatusEngine.activeUsers}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'STREAMS: ${TVLiveStatusEngine.streams}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
