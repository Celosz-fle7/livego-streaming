import 'package:flutter/material.dart';

class TVSmartSecurityPanel
    extends StatelessWidget {
  final bool vpn;
  final bool encrypted;

  const TVSmartSecurityPanel({
    super.key,
    required this.vpn,
    required this.encrypted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.shield,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            vpn
                ? 'VPN ENABLED'
                : 'VPN DISABLED',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            encrypted
                ? 'Encrypted'
                : 'Unencrypted',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
