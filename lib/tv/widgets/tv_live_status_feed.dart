import 'package:flutter/material.dart';

import '../live/tv_live_event_stream.dart';

class TVLiveStatusFeed
    extends StatefulWidget {

  const TVLiveStatusFeed({
    super.key,
  });

  @override
  State<TVLiveStatusFeed>
      createState() =>
          _TVLiveStatusFeedState();
}

class _TVLiveStatusFeedState
    extends State<TVLiveStatusFeed> {

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
            BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            'LIVE STATUS FEED',
            style: TextStyle(
              color: Colors.cyan,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount:
                  events.length,

              itemBuilder:
                  (_, i) {

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 6,
                  ),

                  child: Text(
                    events[i],
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
