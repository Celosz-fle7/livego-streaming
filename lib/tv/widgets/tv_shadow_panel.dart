import 'package:flutter/material.dart';

class TVShadowPanel
    extends StatelessWidget {
  final Widget child;

  const TVShadowPanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.45,
            ),
            blurRadius: 30,
          ),
        ],
      ),
      child: child,
    );
  }
}
