class AuthState {
  final bool loggedIn;
  final String userId;
  final String name;

  const AuthState({
    required this.loggedIn,
    this.userId = '',
    this.name = '',
  });
}
