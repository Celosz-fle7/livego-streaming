import 'package:flutter/material.dart';

import '../../api/models/content_item.dart';
import '../../api/repositories/content_repository.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  bool _loading = false;
  List<ContentItem> _items = [];

  Future<void> _search() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return;

    setState(() => _loading = true);

    final res = await ContentRepository.search(q);

    if (!mounted) return;

    setState(() {
      _items = res.data ?? [];
      _loading = false;
    });
  }

  void _open(ContentItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF070B12),
        title: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Cari film...',
            hintStyle: TextStyle(color: Colors.white38),
          ),
          onSubmitted: (_) => _search(),
        ),
        actions: [
          IconButton(
            onPressed: _search,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF04D2FF)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: _items.length,
              itemBuilder: (_, i) {
                final item = _items[i];

                return ListTile(
                  onTap: () => _open(item),
                  leading: const Icon(Icons.movie, color: Colors.white54),
                  title: Text(
                    item.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    item.type,
                    style: const TextStyle(color: Colors.white54),
                  ),
                );
              },
            ),
    );
  }
}
