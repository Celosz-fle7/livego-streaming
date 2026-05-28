import 'package:flutter/material.dart';

class TVRelatedSection
    extends StatelessWidget {
  final List items;

  const TVRelatedSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Container(
            width: 170,
            margin:
                const EdgeInsets.only(
              right: 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(14),
              child: Image.network(
                item['cover'] ?? '',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
