// lib/shared/widgets/drama_card.dart
// FINAL - WORKER COMPATIBLE

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DramaCard extends StatelessWidget {
  final Map<String, dynamic> drama;
  final bool isFocused;
  final bool isTV;
  final VoidCallback onTap;

  const DramaCard({
    super.key,
    required this.drama,
    required this.onTap,
    this.isFocused = false,
    this.isTV = false,
  });

  @override
  Widget build(BuildContext context) {
    final title = drama['title'] ?? '';
    final cover = drama['cover'] ?? '';
    final ep = drama['total_episodes']?.toString() ?? 
               drama['total_chapter']?.toString() ?? 
               drama['chapters']?.toString() ?? '';
    final views = drama['views']?.toString() ?? '';

    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isTV ? 14 : 10),
            border: Border.all(
              color: isFocused
                  ? const Color(0xFF06B6D4)
                  : Colors.white.withOpacity(0.06),
              width: isFocused ? 2.5 : 1,
            ),
            boxShadow: isFocused
                ? [BoxShadow(
                    color: const Color(0xFF06B6D4).withOpacity(0.45),
                    blurRadius: 16,
                    spreadRadius: 1,
                  )]
                : [BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                  )],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isTV ? 13 : 9),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: cover,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: const Color(0xFF1A2232)),
                    errorWidget: (_, __, ___) => Container(
                      color: const Color(0xFF1A2232),
                      child: const Center(
                        child: Icon(Icons.movie_outlined, color: Colors.white24, size: 32),
                      ),
                    ),
                    memCacheWidth: isTV ? 300 : 200,
                    memCacheHeight: isTV ? 450 : 300,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ),
                if (ep.isNotEmpty)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.3), width: 0.5),
                      ),
                      child: Text(
                        '$ep Ep',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 6,
                  right: 6,
                  bottom: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (views.isNotEmpty)
                        Text(
                          views,
                          style: const TextStyle(
                            color: Color(0xFF06B6D4),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 2),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTV ? 11 : 10,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isFocused)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF06B6D4).withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(13),
                        color: const Color(0xFF06B6D4).withOpacity(0.08),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
