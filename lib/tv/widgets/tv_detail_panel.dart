import 'package:flutter/material.dart';

class TVDetailPanel
    extends StatelessWidget {
  final Widget child;

  const TVDetailPanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: child,
    );
  }
}
