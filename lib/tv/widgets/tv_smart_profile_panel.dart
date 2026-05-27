import 'package:flutter/material.dart';

class TVSmartProfilePanel
    extends StatelessWidget {
  final int profiles;

  const TVSmartProfilePanel({
    super.key,
    required this.profiles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor:
                Color(0xFF04D2FF),
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$profiles Profiles',
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
