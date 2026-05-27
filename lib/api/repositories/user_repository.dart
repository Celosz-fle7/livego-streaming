import '../cache/local_store.dart';
import '../models/user_profile.dart';

class UserRepository {

  static const _key =
      'user_profile';

  static Future<void> save(
    UserProfile profile,
  ) async {

    await LocalStore.set(
      _key,
      profile.toJson(),
    );
  }

  static Future<UserProfile?>
      current() async {

    final raw =
        await LocalStore.get(_key);

    if (raw is! Map) {
      return null;
    }

    return UserProfile.fromJson(
      Map<String, dynamic>.from(raw),
    );
  }

  static Future<void> logout()
      async {

    await LocalStore.remove(
      _key,
    );
  }
}
