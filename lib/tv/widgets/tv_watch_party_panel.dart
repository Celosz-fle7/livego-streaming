import 'package:flutter/material.dart';

class TVWatchPartyPanel
    extends StatelessWidget {
  final bool active;
  final int members;

  const TVWatchPartyPanel({
    super.key,
    required this.active,
    required this.members,
  });

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
          Icon(
            active
                ? Icons.groups
                : Icons.group_off,
            color:
                active ? Colors.green : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            active
                ? '$members Members'
                : 'No Party',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
