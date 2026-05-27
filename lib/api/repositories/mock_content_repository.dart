import '../models/content_item.dart';
import '../models/content_detail.dart';
import '../models/video_source.dart';

class MockContentRepository {
  static List<ContentItem> trending() {
    return const [
      ContentItem(
        id: 'mock_1',
        title: 'Demo Movie',
        poster: '',
        type: 'movie',
      ),
      ContentItem(
        id: 'mock_2',
        title: 'Demo Series',
        poster: '',
        type: 'series',
      ),
    ];
  }

  static ContentDetail detail(String id) {
    return ContentDetail(
      id: id,
      title: 'Demo Detail',
      poster: '',
      description: 'Offline fallback content.',
      genres: const ['Demo'],
    );
  }

  static List<VideoSource> videos(String id) {
    return const [
      VideoSource(
        url: '',
        quality: 'demo',
        type: 'hls',
      ),
    ];
  }
}
