import 'package:flutter/material.dart';

import '../../api/models/content_item.dart';
import '../../api/repositories/content_repository.dart';
import 'detail_screen.dart';
import '../../api/repositories/watch_history_repository.dart';
import '../../api/models/watch_history_item.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  bool _loading = true;
  List<ContentItem> _trending = [];
  List<ContentItem> _latest = [];
  List<WatchHistoryItem> _continue = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final trending = await ContentRepository.trending();
    final latest = await ContentRepository.search('latest');
    final cont = await WatchHistoryRepository.continueWatching();

    if (!mounted) return;

    setState(() {
      _trending = trending.data ?? [];
      _latest = latest.data ?? [];
      _continue = cont.data ?? [];
      _loading = false;
    });
  }

  Widget _poster(ContentItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(item: item),
          ),
        );
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF151A26),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: item.poster.isEmpty
                  ? Container(
                      color: const Color(0xFF202636),
                      child: const Center(
                        child: Icon(Icons.movie, color: Colors.white38),
                      ),
                    )
                  : Image.network(
                      item.poster,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF202636),
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.white38),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _continueCard(WatchHistoryItem item) {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151A26),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.play_circle, color: Color(0xFF04D2FF), size: 42),
          const Spacer(),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: item.progress.clamp(0, 1),
            minHeight: 5,
            backgroundColor: Colors.white12,
            valueColor: const AlwaysStoppedAnimation(Color(0xFF04D2FF)),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(height: 210, child: child),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFF070B12),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF04D2FF)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const Text(
              'LiveGO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            if (_continue.isNotEmpty)
              _section(
                'Continue Watching',
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: _continue.map(_continueCard).toList(),
                ),
              ),

            _section(
              'Trending',
              ListView(
                scrollDirection: Axis.horizontal,
                children: _trending.map(_poster).toList(),
              ),
            ),

            _section(
              'Latest Update',
              ListView(
                scrollDirection: Axis.horizontal,
                children: _latest.map(_poster).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
