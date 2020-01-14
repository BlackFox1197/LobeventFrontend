class User {
  final String username;
  final String password;

  User(this.username, this.password);

  User.fromJson(Map<String, dynamic> json)
      : username = json["name"],
        password = json["password"];
}
