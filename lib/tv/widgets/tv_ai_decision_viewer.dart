import 'package:flutter/material.dart';

import '../decision/tv_auto_decision_engine.dart';

class TVAIDecisionViewer
    extends StatelessWidget {

  const TVAIDecisionViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final decisions =
        TVAutoDecisionEngine.decisions;

    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: ListView.builder(
        itemCount:
            decisions.length,

        itemBuilder:
            (_, i) {

          return Padding(
            padding:
                const EdgeInsets.symmetric(
              vertical: 6,
            ),

            child: Text(
              decisions[i],
              style: const TextStyle(
                color: Colors.cyan,
              ),
            ),
          );
        },
      ),
    );
  }
}
