class UserModel {
  final String uid;
  final String username;
  final String email;
  final int points;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.points = 0,
  });
}
