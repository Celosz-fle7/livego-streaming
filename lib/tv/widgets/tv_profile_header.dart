import 'package:flutter/material.dart';

class TVProfileHeader
    extends StatelessWidget {
  final String username;
  final bool premium;

  const TVProfileHeader({
    super.key,
    required this.username,
    required this.premium,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor:
              const Color(0xFF04D2FF),
          child: Text(
            username
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
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              premium
                  ? 'Premium Member'
                  : 'Free Member',
              style: TextStyle(
                color: premium
                    ? const Color(
                        0xFFFFD54F,
                      )
                    : Colors.white54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
