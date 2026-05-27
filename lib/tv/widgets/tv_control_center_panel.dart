import 'package:flutter/material.dart';

class TVControlCenterPanel
    extends StatelessWidget {

  final bool online;

  final bool maintenance;

  final int commands;

  const TVControlCenterPanel({
    super.key,
    required this.online,
    required this.maintenance,
    required this.commands,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 420,
      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          Icon(
            online
                ? Icons.settings_remote
                : Icons.portable_wifi_off,

            color:
                online
                    ? Colors.green
                    : Colors.red,

            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$commands',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            maintenance
                ? 'MAINTENANCE'
                : 'ONLINE',

            style: TextStyle(
              color:
                  maintenance
                      ? Colors.orange
                      : Colors.green,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
