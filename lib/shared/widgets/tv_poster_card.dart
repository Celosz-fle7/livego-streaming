import 'package:flutter/material.dart';

class TVPosterCard extends StatefulWidget {

  final String title;
  final String image;
  final bool focused;
  final VoidCallback onTap;

  const TVPosterCard({
    super.key,
    required this.title,
    required this.image,
    required this.focused,
    required this.onTap,
  });

  @override
  State<TVPosterCard> createState() =>
      _TVPosterCardState();
}

class _TVPosterCardState
    extends State<TVPosterCard> {

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
      child: AnimatedScale(
        scale: widget.focused
            ? 1.08
            : 1.0,
        duration: const Duration(
          milliseconds: 140,
        ),

        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 140,
          ),

          width: 180,
          height: 270,

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(14),

            border: Border.all(
              color: widget.focused
                  ? const Color(0xFF04D2FF)
                  : Colors.transparent,
              width: 3,
            ),

            boxShadow: widget.focused
                ? [
                    const BoxShadow(
                      color: Color(0x6604D2FF),
                      blurRadius: 18,
                    ),
                  ]
                : [],
          ),

          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(12),

            child: Stack(
              fit: StackFit.expand,
              children: [

                // IMAGE
                Image.network(
                  widget.image,
                  fit: BoxFit.cover,

                  errorBuilder:
                      (_, __, ___) {
                    return Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.white24,
                        ),
                      ),
                    );
                  },
                ),

                // OVERLAY
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,

                  child: Container(
                    padding:
                        const EdgeInsets.all(10),

                    decoration:
                        BoxDecoration(
                      gradient:
                          LinearGradient(
                        begin:
                            Alignment
                                .bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black
                              .withOpacity(
                                  0.95),
                          Colors.transparent,
                        ],
                      ),
                    ),

                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight:
                            FontWeight.bold,
                      ),
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
