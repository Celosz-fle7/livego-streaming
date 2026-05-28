import '../cache/local_store.dart';
import '../models/favorite_item.dart';

class FavoriteRepository {

  static const _key =
      'favorites';

  static Future<List<FavoriteItem>>
      all() async {

    final raw =
        await LocalStore.get(_key);

    if (raw is! List) {
      return [];
    }

    return raw.map((e) {

      return FavoriteItem.fromJson(
        Map<String, dynamic>.from(e),
      );

    }).toList();
  }

  static Future<void> add(
    FavoriteItem item,
  ) async {

    final list = await all();

    final exists = list.any(
      (e) => e.id == item.id,
    );

    if (exists) return;

    list.add(item);

    await LocalStore.set(
      _key,
      list.map((e) {

        return e.toJson();

      }).toList(),
    );
  }

  static Future<void> remove(
    String id,
  ) async {

    final list = await all();

    list.removeWhere(
      (e) => e.id == id,
    );

    await LocalStore.set(
      _key,
      list.map((e) {

        return e.toJson();

      }).toList(),
    );
  }

  static Future<bool> exists(
    String id,
  ) async {

    final list = await all();

    return list.any(
      (e) => e.id == id,
    );
  }
}
