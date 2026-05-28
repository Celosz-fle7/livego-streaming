import 'package:flutter/material.dart';

class TVLowMemoryBanner
    extends StatelessWidget {

  const TVLowMemoryBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin:
          const EdgeInsets.all(12),

      padding:
          const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.orange.shade900,
        borderRadius:
            BorderRadius.circular(14),
      ),

      child: const Row(
        children: [

          Icon(
            Icons.memory,
            color: Colors.white,
          ),

          SizedBox(width: 12),

          Expanded(
            child: Text(
              'LOW MEMORY MODE ENABLED',
              style: TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
