class UserProfile {
  final String username;
  final int points;
  final String userId;

  UserProfile({
    required this.username,
    required this.points,
    required this.userId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] ?? '',
      points: json['points'] ?? 0,
      userId: json['user_id'] ?? '',
    );
  }
}
