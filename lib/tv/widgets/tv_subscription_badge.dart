import 'package:flutter/material.dart';

class TVSubscriptionBadge
    extends StatelessWidget {
  final String plan;

  const TVSubscriptionBadge({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: plan == 'FREE'
            ? Colors.grey
            : Colors.amber,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        plan,
        style: TextStyle(
          color: plan == 'FREE'
              ? Colors.white
              : Colors.black,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
