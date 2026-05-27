import 'package:flutter/material.dart';

import '../../api/models/content_item.dart';
import '../../api/repositories/content_repository.dart';
import 'player_screen.dart';

class DetailScreen extends StatefulWidget {
  final ContentItem item;

  const DetailScreen({
    super.key,
    required this.item,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _loading = true;
  String _description = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final res = await ContentRepository.detail(widget.item.id);

    if (!mounted) return;

    setState(() {
      _description = res.data?.description ?? 'Belum ada deskripsi.';
      _loading = false;
    });
  }

  Future<void> _play() async {
    final res = await ContentRepository.videos(widget.item.id);
    final videos = res.data ?? [];
    final url = videos.isNotEmpty ? videos.first.url : '';

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(
          title: widget.item.title,
          streamUrl: url,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF070B12),
        title: Text(widget.item.title),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF04D2FF)),
            )
          : ListView(
              padding: const EdgeInsets.all(22),
              children: [
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: const Color(0xFF151A26),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(Icons.movie, color: Colors.white38, size: 90),
                ),
                const SizedBox(height: 22),
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _description,
                  style: const TextStyle(color: Colors.white70, height: 1.5),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _play,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play'),
                ),
              ],
            ),
    );
  }
}
