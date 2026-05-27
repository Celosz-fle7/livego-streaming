import 'package:flutter/material.dart';

class TVLazyRail extends StatefulWidget {
  final Widget child;

  const TVLazyRail({
    super.key,
    required this.child,
  });

  @override
  State<TVLazyRail> createState() =>
      _TVLazyRailState();
}

class _TVLazyRailState
    extends State<TVLazyRail> {
  bool _visible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        if (mounted) {
          setState(() {
            _visible = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox(
        height: 260,
      );
    }

    return widget.child;
  }
}
