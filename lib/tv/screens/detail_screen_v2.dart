import 'package:flutter/material.dart';

import '../../core/dracin/dracin_repository.dart';
import '../../core/tv/tv_focus_manager.dart';
import '../../shared/widgets/tv_poster_card.dart';

class TVDetailScreenV2 extends StatefulWidget {

  final String id;
  final String source;
  final String title;

  const TVDetailScreenV2({
    super.key,
    required this.id,
    required this.source,
    required this.title,
  });

  @override
  State<TVDetailScreenV2> createState() =>
      _TVDetailScreenV2State();
}

class _TVDetailScreenV2State
    extends State<TVDetailScreenV2> {

  bool _loading = true;

  Map<String, dynamic>? _detail;

  int _episodes = 1;

  @override
  void initState() {
    super.initState();

    _load();
  }

  Future<void> _load() async {

    final data =
        await DracinRepository
            .getDetail(
      widget.id,
      widget.source,
    );

    if (!mounted) return;

    int eps =
        data?['total_episodes'] ??
            1;

    if (eps is! int) {
      eps =
          int.tryParse(
                eps.toString(),
              ) ??
              1;
    }

    setState(() {
      _detail = data;
      _episodes = eps;
      _loading = false;
    });

    TVFocusManager.request(
      'play_button',
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0B0F14),

      body: _loading
          ? const Center(
              child:
                  CircularProgressIndicator(
                color:
                    Color(0xFF04D2FF),
              ),
            )
          : _buildContent(),
    );
  }

  Widget _buildContent() {

    return ListView(
      padding:
          const EdgeInsets.all(32),

      children: [

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // POSTER
            TVPosterCard(
              title:
                  widget.title,

              image:
                  _detail?['cover']
                          ?.toString() ??
                      '',

              focused: false,

              onTap: () {},
            ),

            const SizedBox(
              width: 40,
            ),

            // INFO
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(
                    widget.title,

                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontSize: 36,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    _detail?['synopsis']
                            ?.toString() ??
                        'No synopsis',

                    maxLines: 8,
                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(
                      color:
                          Colors.white70,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // PLAY BUTTON
                  Focus(
                    focusNode:
                        TVFocusManager
                            .getNode(
                      'play_button',
                    ),

                    child: Builder(
                      builder: (ctx) {

                        final focused =
                            Focus.of(ctx)
                                .hasFocus;

                        return AnimatedScale(
                          scale: focused
                              ? 1.05
                              : 1.0,

                          duration:
                              const Duration(
                            milliseconds:
                                140,
                          ),

                          child:
                              Container(
                            width: 220,
                            height: 58,

                            decoration:
                                BoxDecoration(
                              color:
                                  focused
                                      ? const Color(
                                          0xFF04D2FF,
                                        )
                                      : Colors
                                          .white,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),

                            child: const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                              children: [

                                Icon(
                                  Icons
                                      .play_arrow,
                                  color: Colors
                                      .black,
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  'PLAY NOW',

                                  style:
                                      TextStyle(
                                    color: Colors
                                        .black,

                                    fontWeight:
                                        FontWeight
                                            .bold,

                                    fontSize:
                                        16,
                                  ),
                                ),
                              ],
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

        const SizedBox(
          height: 50,
        ),

        const Text(
          'Episodes',

          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        GridView.builder(
          shrinkWrap: true,

          physics:
              const NeverScrollableScrollPhysics(),

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 2,
          ),

          itemCount: _episodes,

          itemBuilder: (_, index) {

            final ep = index + 1;

            return Focus(
              focusNode:
                  TVFocusManager
                      .getNode(
                'ep_$ep',
              ),

              child: Builder(
                builder: (ctx) {

                  final focused =
                      Focus.of(ctx)
                          .hasFocus;

                  return AnimatedContainer(
                    duration:
                        const Duration(
                      milliseconds:
                          120,
                    ),

                    decoration:
                        BoxDecoration(
                      color: focused
                          ? const Color(
                              0xFF04D2FF,
                            )
                          : Colors
                              .white10,

                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),

                    child: Center(
                      child: Text(
                        'EP $ep',

                        style:
                            TextStyle(
                          color: focused
                              ? Colors.black
                              : Colors.white,

                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
