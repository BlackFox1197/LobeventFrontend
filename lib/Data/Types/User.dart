class User {
  final String email;
  final String password;

  User(this.email, this.password);

  User.fromJson(Map<String, dynamic> json)
      : email = json["name"],
        password = json["password"];

  Map<String, dynamic> toJson() =>
      {
        'email' : email,
        'password' : password,
      };

  Map<String, dynamic> toLoginJson() =>
      {
        'username' : email,
        'password' : password,
      };

}
