import 'package:flutter/material.dart';

class TVContinueWatchingCard
    extends StatelessWidget {

  final String title;

  final String poster;

  final double progress;

  const TVContinueWatchingCard({
    super.key,
    required this.title,
    required this.poster,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 260,

      decoration: BoxDecoration(
        color: Colors.black87,

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(18),
              ),

              child: Image.network(
                poster,
                width: double.infinity,
                fit: BoxFit.cover,

                errorBuilder:
                    (_, __, ___) {

                  return Container(
                    color: Colors.grey[900],
                  );
                },
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.all(12),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(99),

                  child:
                      LinearProgressIndicator(
                    value: progress,

                    minHeight: 6,

                    backgroundColor:
                        Colors.white12,

                    valueColor:
                        const AlwaysStoppedAnimation(
                      Color(0xFF04D2FF),
                    ),
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
