class UserRole {
  final String role;

  const UserRole({
    required this.role,
  });

  bool get isAdmin => role == 'admin';

  bool get isUser => role == 'user';
}
