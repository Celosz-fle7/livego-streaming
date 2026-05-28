import 'package:flutter/material.dart';

class TVBufferOverlay
    extends StatelessWidget {
  const TVBufferOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: const Center(
        child:
            CircularProgressIndicator(
          color: Color(0xFF04D2FF),
        ),
      ),
    );
  }
}
