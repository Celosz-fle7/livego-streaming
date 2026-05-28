import 'package:flutter/material.dart';

class TVRenderPipelinePanel extends StatelessWidget {
  final bool repaint;
  final bool lazy;
  final int cache;

  const TVRenderPipelinePanel({
    super.key,
    required this.repaint,
    required this.lazy,
    required this.cache,
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
          const Icon(
            Icons.layers,
            color: Colors.deepPurple,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            lazy ? 'LAZY GRID' : 'STATIC GRID',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Repaint ${repaint ? "ON" : "OFF"} • Cache $cache',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
