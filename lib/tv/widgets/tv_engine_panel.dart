import 'package:flutter/material.dart';

class TVEnginePanel
    extends StatelessWidget {
  final bool cache;
  final bool preload;
  final bool adaptive;

  const TVEnginePanel({
    super.key,
    required this.cache,
    required this.preload,
    required this.adaptive,
  });

  Widget _row(
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
                ? Icons.check_circle
                : Icons.cancel,
            color: active
                ? Colors.green
                : Colors.red,
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
      width: 280,
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
        mainAxisSize:
            MainAxisSize.min,
        children: [
          const Text(
            'Engine Status',
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 18),
          _row('Cache Engine', cache),
          _row('Preload Engine', preload),
          _row('Adaptive Stream', adaptive),
        ],
      ),
    );
  }
}
