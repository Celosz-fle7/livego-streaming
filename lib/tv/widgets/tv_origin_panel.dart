import 'package:flutter/material.dart';

class TVOriginPanel
    extends StatelessWidget {
  final int origins;

  const TVOriginPanel({
    super.key,
    required this.origins,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.radio_button_checked,
            color: Colors.orange,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            '$origins Origins',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
