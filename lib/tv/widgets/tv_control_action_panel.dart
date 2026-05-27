import 'package:flutter/material.dart';

class TVControlActionPanel extends StatelessWidget {
  final VoidCallback onRestart;
  final VoidCallback onClearCache;
  final VoidCallback onOptimize;

  const TVControlActionPanel({
    super.key,
    required this.onRestart,
    required this.onClearCache,
    required this.onOptimize,
  });

  Widget _button(String text, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button('Restart System', Icons.restart_alt, onRestart),
          _button('Clear Cache', Icons.delete_sweep, onClearCache),
          _button('Optimize', Icons.rocket_launch, onOptimize),
        ],
      ),
    );
  }
}
