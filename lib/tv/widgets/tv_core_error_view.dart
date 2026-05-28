import 'package:flutter/material.dart';

class TVCoreErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const TVCoreErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 520,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.orange, size: 72),
            const SizedBox(height: 20),
            Text(
              message.isEmpty ? 'Something went wrong' : message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
