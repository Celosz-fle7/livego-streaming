import '../models/api_response.dart';
import '../models/user_profile.dart';
import 'auth_repository.dart';
import 'auth_state_repository.dart';

class AuthActionRepository {
  static Future<ApiResponse<bool>> mockSignIn() async {
    final res = await AuthRepository.mockLogin(
      name: 'TV User',
    );

    if (!res.success || res.data == null) {
      return ApiResponse.fail(res.error);
    }

    await AuthStateRepository.setProfile(
      res.data as UserProfile,
    );

    return ApiResponse.ok(true);
  }

  static Future<void> signOut() async {
    await AuthStateRepository.logout();
  }
}
