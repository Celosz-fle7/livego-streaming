import '../models/tv_download_item.dart';

class TVDownloadController {
  static final List<TVDownloadItem>
      downloads = [];

  static void add(
    TVDownloadItem item,
  ) {
    downloads.removeWhere(
      (e) => e.id == item.id,
    );

    downloads.add(item);
  }

  static void remove(String id) {
    downloads.removeWhere(
      (e) => e.id == id,
    );
  }
}
