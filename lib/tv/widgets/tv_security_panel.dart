import 'package:flutter/material.dart';

class TVSecurityPanel
    extends StatelessWidget {
  final bool antiDebug;
  final bool antiTamper;
  final bool secure;

  const TVSecurityPanel({
    super.key,
    required this.antiDebug,
    required this.antiTamper,
    required this.secure,
  });

  Widget item(
    String text,
    bool active,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: [
          Icon(
            active
                ? Icons.verified
                : Icons.warning,
            color: active
                ? Colors.green
                : Colors.orange,
            size: 18,
          ),
          const SizedBox(width: 10),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          item(
            'Anti Debug',
            antiDebug,
          ),
          item(
            'Anti Tamper',
            antiTamper,
          ),
          item(
            'Secure Mode',
            secure,
          ),
        ],
      ),
    );
  }
}
