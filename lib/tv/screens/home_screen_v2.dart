import 'package:flutter/material.dart';

import '../../core/models/tv_home_section.dart';
import '../../core/tv/tv_focus_manager.dart';
import '../../core/tv/tv_home_controller.dart';
import '../../core/tv/tv_row_controller.dart';
import '../../shared/widgets/tv_poster_card.dart';

class TVHomeScreenV2 extends StatefulWidget {
  const TVHomeScreenV2({super.key});

  @override
  State<TVHomeScreenV2> createState() =>
      _TVHomeScreenV2State();
}

class _TVHomeScreenV2State
    extends State<TVHomeScreenV2> {

  bool _loading = true;

  List<TVHomeSection> _sections = [];

  final Map<String, TVRowController>
      _rows = {};

  @override
  void initState() {
    super.initState();

    _load();
  }

  Future<void> _load() async {

    final data =
        await TVHomeController
            .loadHome();

    if (!mounted) return;

    for (final s in data) {
      _rows[s.id] =
          TVRowController(
        sectionId: s.id,
      );
    }

    setState(() {
      _sections = data;
      _loading = false;
    });

    if (data.isNotEmpty &&
        data.first.items.isNotEmpty) {

      TVFocusManager.request(
        '${data.first.id}-0',
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0B0F14),

      body: _loading
          ? _buildLoading()
          : _buildContent(),
    );
  }

  Widget _buildLoading() {

    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF04D2FF),
      ),
    );
  }

  Widget _buildContent() {

    return ListView.builder(
      padding:
          const EdgeInsets.only(
        top: 40,
        bottom: 60,
      ),

      itemCount: _sections.length,

      itemBuilder: (_, sectionIndex) {

        final section =
            _sections[sectionIndex];

        final row =
            _rows[section.id]!;

        return RepaintBoundary(
          child: Padding(
            padding:
                const EdgeInsets.only(
              bottom: 40,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // TITLE
                Padding(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 32,
                  ),

                  child: Text(
                    section.title,

                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // ROW
                SizedBox(
                  height: 290,

                  child: ListView.builder(
                    controller:
                        row.scrollController,

                    scrollDirection:
                        Axis.horizontal,

                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 32,
                    ),

                    itemCount:
                        section.items.length,

                    itemBuilder:
                        (_, index) {

                      final item =
                          section.items[index];

                      final focusId =
                          '${section.id}-$index';

                      return Padding(
                        padding:
                            const EdgeInsets
                                .only(
                          right: 18,
                        ),

                        child: Focus(
                          focusNode:
                              TVFocusManager
                                  .getNode(
                            focusId,
                          ),

                          autofocus:
                              sectionIndex == 0 &&
                                  index == 0,

                          onFocusChange:
                              (focused) {

                            if (focused) {

                              row.setFocus(
                                index,
                              );

                              setState(() {});
                            }
                          },

                          child: Builder(
                            builder: (ctx) {

                              final focused =
                                  Focus.of(
                                ctx,
                              ).hasFocus;

                              return TVPosterCard(
                                title:
                                    item['title']
                                            ?.toString() ??
                                        'No Title',

                                image:
                                    item['cover']
                                            ?.toString() ??
                                        '',

                                focused:
                                    focused,

                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
