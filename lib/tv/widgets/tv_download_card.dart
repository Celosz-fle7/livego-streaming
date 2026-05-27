import 'package:flutter/material.dart';

class TVDownloadCard
    extends StatelessWidget {
  final String title;
  final String image;
  final double progress;

  const TVDownloadCard({
    super.key,
    required this.title,
    required this.image,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor:
                      Colors.white24,
                  valueColor:
                      const AlwaysStoppedAnimation(
                    Color(0xFF04D2FF),
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
