import 'package:flutter/material.dart';

class TVStartupCachePanel
    extends StatelessWidget {
  final bool home;
  final bool images;
  final bool genres;

  const TVStartupCachePanel({
    super.key,
    required this.home,
    required this.images,
    required this.genres,
  });

  Widget row(
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
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          row(
            'Preload Home',
            home,
          ),
          row(
            'Preload Images',
            images,
          ),
          row(
            'Preload Genres',
            genres,
          ),
        ],
      ),
    );
  }
}
