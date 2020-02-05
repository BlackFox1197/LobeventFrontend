
class Profile {
  final String userName;
  final String userId;

  Profile({this.userName, this.userId});

  factory Profile.fromJson(Map<String, dynamic> json) {
    final profile = Profile(
        userName: json['userName'] as String,
        userId: json['userId'] as String,
    );
    return profile;
  }
}