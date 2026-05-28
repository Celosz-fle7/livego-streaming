import 'package:flutter/material.dart';

class TVSmartRemotePanel
    extends StatelessWidget {
  final bool connected;
  final String device;

  const TVSmartRemotePanel({
    super.key,
    required this.connected,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            connected
                ? Icons.settings_remote
                : Icons.portable_wifi_off,
            color:
                connected ? Colors.green : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            device,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
