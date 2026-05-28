import '../models/auth_state.dart';
import '../models/user_profile.dart';
import 'user_repository.dart';
import 'session_repository.dart';

class AuthStateRepository {
  static AuthState current = const AuthState(
    loggedIn: false,
  );

  static Future<void> load() async {
    await SessionRepository.load();

    final profile = await UserRepository.current();

    current = AuthState(
      loggedIn: SessionRepository.loggedIn,
      userId: profile?.id ?? '',
      name: profile?.name ?? '',
    );
  }

  static Future<void> setProfile(UserProfile profile) async {
    await UserRepository.save(profile);
    await load();
  }

  static Future<void> logout() async {
    await SessionRepository.logout();
    await UserRepository.logout();
    current = const AuthState(loggedIn: false);
  }
}
