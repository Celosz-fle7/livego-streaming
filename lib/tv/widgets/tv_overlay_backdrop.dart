import 'package:flutter/material.dart';

class TVOverlayBackdrop
    extends StatelessWidget {
  const TVOverlayBackdrop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(
                0.75,
              ),
              Colors.transparent,
              Colors.transparent,
              Colors.black.withOpacity(
                0.82,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
