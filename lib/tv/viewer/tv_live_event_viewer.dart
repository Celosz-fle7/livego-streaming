import 'package:flutter/material.dart';

import '../live/tv_live_event_stream.dart';

class TVLiveEventViewer
    extends StatelessWidget {

  const TVLiveEventViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final events =
        TVLiveEventStream.latest();

    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: ListView.builder(
        itemCount: events.length,

        itemBuilder: (_, i) {

          return Padding(
            padding:
                const EdgeInsets.symmetric(
              vertical: 6,
            ),

            child: Text(
              events[i],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
