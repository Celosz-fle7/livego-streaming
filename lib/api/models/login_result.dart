import 'user_profile.dart';

class LoginResult {
  final String accessToken;
  final String refreshToken;
  final UserProfile profile;

  const LoginResult({
    required this.accessToken,
    required this.refreshToken,
    required this.profile,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      accessToken: '${json['accessToken'] ?? ''}',
      refreshToken: '${json['refreshToken'] ?? ''}',
      profile: UserProfile.fromJson(
        Map<String, dynamic>.from(json['profile'] ?? {}),
      ),
    );
  }
}
