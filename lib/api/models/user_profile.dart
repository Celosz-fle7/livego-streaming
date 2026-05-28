class UserProfile {
  final String id;
  final String name;
  final String avatar;

  const UserProfile({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory UserProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfile(
      id: '${json['id'] ?? ''}',
      name: '${json['name'] ?? ''}',
      avatar: '${json['avatar'] ?? ''}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }
}
