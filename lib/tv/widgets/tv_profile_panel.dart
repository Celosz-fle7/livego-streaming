import 'package:flutter/material.dart';

class TVProfilePanel
    extends StatelessWidget {
  final String name;
  final bool kids;

  const TVProfilePanel({
    super.key,
    required this.name,
    required this.kids,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor:
                const Color(
              0xFF04D2FF,
            ),
            child: Text(
              name
                  .substring(0, 1)
                  .toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight:
                    FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            kids
                ? 'Kids Profile'
                : 'Standard Profile',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
