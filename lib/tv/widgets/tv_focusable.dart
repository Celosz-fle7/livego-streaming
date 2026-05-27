import 'package:flutter/material.dart';

class TVFocusable extends StatefulWidget {
  final Widget Function(bool focused)
      builder;

  final VoidCallback? onTap;

  final FocusNode? focusNode;

  final bool autofocus;

  const TVFocusable({
    super.key,
    required this.builder,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  State<TVFocusable> createState() =>
      _TVFocusableState();
}

class _TVFocusableState
    extends State<TVFocusable> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onFocusChange: (v) {
        if (mounted) {
          setState(() {
            _focused = v;
          });
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: widget.builder(_focused),
      ),
    );
  }
}
