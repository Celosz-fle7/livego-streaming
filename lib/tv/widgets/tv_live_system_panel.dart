import 'package:flutter/material.dart';

class TVLiveSystemPanel
    extends StatelessWidget {

  final String state;

  final int users;

  final int streams;

  const TVLiveSystemPanel({
    super.key,
    required this.state,
    required this.users,
    required this.streams,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 420,
      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          const Icon(
            Icons.live_tv,
            color: Colors.red,
            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            state,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 34,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '$users USERS',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '$streams STREAMS',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
