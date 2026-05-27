import 'package:flutter/material.dart';

import '../live/tv_live_event_stream.dart';
import '../terminal/tv_system_terminal_engine.dart';

class TVDualConsolePanel extends StatefulWidget {
  const TVDualConsolePanel({super.key});

  @override
  State<TVDualConsolePanel> createState() =>
      _TVDualConsolePanelState();
}

class _TVDualConsolePanelState
    extends State<TVDualConsolePanel> {

  @override
  Widget build(BuildContext context) {

    final terminal =
        TVSystemTerminalEngine.output;

    final events =
        TVLiveEventStream.latest();

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Text(
                  'SYSTEM TERMINAL',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 14),

                Expanded(
                  child: ListView.builder(
                    itemCount:
                        terminal.length,

                    itemBuilder:
                        (_, i) {

                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 4,
                        ),

                        child: Text(
                          terminal[i],
                          style:
                              const TextStyle(
                            color:
                                Colors.green,
                            fontFamily:
                                'monospace',
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Text(
                  'LIVE EVENTS',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 14),

                Expanded(
                  child: ListView.builder(
                    itemCount:
                        events.length,

                    itemBuilder:
                        (_, i) {

                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 4,
                        ),

                        child: Text(
                          events[i],
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
