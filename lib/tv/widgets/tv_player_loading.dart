import 'package:flutter/material.dart';

class TVPlayerLoading
    extends StatelessWidget {
  const TVPlayerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF04D2FF),
      ),
    );
  }
}
