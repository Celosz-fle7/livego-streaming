import 'package:flutter/material.dart';

class TVFocusCardWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const TVFocusCardWrapper({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<TVFocusCardWrapper> createState() => _TVFocusCardWrapperState();
}

class _TVFocusCardWrapperState extends State<TVFocusCardWrapper> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (v) => setState(() => _focused = v),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _focused ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 90),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _focused ? const Color(0xFF04D2FF) : Colors.transparent,
                width: 3,
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
