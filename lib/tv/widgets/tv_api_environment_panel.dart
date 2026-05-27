import 'package:flutter/material.dart';

class TVApiEnvironmentPanel extends StatelessWidget {
  final bool hasBackend;
  final String baseUrl;

  const TVApiEnvironmentPanel({
    super.key,
    required this.hasBackend,
    required this.baseUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            hasBackend ? Icons.link : Icons.link_off,
            color: hasBackend ? Colors.green : Colors.orange,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            hasBackend ? 'BACKEND READY' : 'MOCK MODE',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            baseUrl.isEmpty ? 'No API_BASE_URL' : baseUrl,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
