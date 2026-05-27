import 'package:flutter/material.dart';

class TVLoading extends StatelessWidget {
  final String text;

  const TVLoading({
    super.key,
    this.text = 'Memuat...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF04D2FF),
          ),
          const SizedBox(height: 18),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
