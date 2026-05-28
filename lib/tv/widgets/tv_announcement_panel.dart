import 'package:flutter/material.dart';

class TVAnnouncementPanel
    extends StatelessWidget {
  final String text;

  const TVAnnouncementPanel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.campaign,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
