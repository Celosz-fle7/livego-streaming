import 'package:flutter/material.dart';

class TVGPUBadge
    extends StatelessWidget {
  final bool hdr;

  const TVGPUBadge({
    super.key,
    required this.hdr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color:
            hdr ? Colors.purple : Colors.blueGrey,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        hdr ? 'HDR' : 'SDR',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
