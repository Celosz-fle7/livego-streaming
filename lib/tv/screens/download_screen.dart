import 'package:flutter/material.dart';

import '../../core/tv/tv_download_controller.dart';

import '../widgets/tv_download_card.dart';

class TVDownloadScreen
    extends StatelessWidget {
  const TVDownloadScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items =
        TVDownloadController.downloads;

    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: Padding(
        padding:
            const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Unduhan Saya',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                  childAspectRatio: 0.78,
                ),
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final item =
                      items[i];

                  return TVDownloadCard(
                    title: item.title,
                    image: item.poster,
                    progress:
                        item.progress,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
