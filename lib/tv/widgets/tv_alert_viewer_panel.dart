import 'package:flutter/material.dart';

import '../alerts/tv_auto_alert_engine.dart';

class TVAlertViewerPanel
    extends StatelessWidget {

  const TVAlertViewerPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final alerts =
        TVAutoAlertEngine.alerts;

    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: ListView.builder(
        itemCount:
            alerts.length,

        itemBuilder:
            (_, i) {

          return Padding(
            padding:
                const EdgeInsets.symmetric(
              vertical: 6,
            ),

            child: Text(
              alerts[i],
              style: const TextStyle(
                color: Colors.orange,
              ),
            ),
          );
        },
      ),
    );
  }
}
