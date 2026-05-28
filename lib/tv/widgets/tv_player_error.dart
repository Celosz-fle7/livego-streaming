import 'package:flutter/material.dart';

class TVPlayerError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const TVPlayerError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF070B12),
      child: Center(
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white38,
              size: 60,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text(
                'Coba Lagi',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
