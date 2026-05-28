import 'package:flutter/material.dart';

class TVSideEpisodePanel
    extends StatelessWidget {
  final int current;
  final int total;
  final Function(int ep) onSelect;

  const TVSideEpisodePanel({
    super.key,
    required this.current,
    required this.total,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      color: Colors.black87,
      child: ListView.builder(
        itemCount: total,
        itemBuilder: (_, i) {
          final ep = i + 1;

          final selected =
              ep == current;

          return GestureDetector(
            onTap: () => onSelect(ep),
            child: Container(
              height: 54,
              margin:
                  const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(
                        0xFF04D2FF,
                      )
                    : Colors.white10,
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'EP $ep',
                style: TextStyle(
                  color: selected
                      ? Colors.black
                      : Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
