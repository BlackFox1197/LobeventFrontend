class LoginResponse {
  String token;


  LoginResponse({this.token});

  factory LoginResponse.fromJSON(Map<String, dynamic> json){
    final loginResponse = LoginResponse(
      token : json['token'] as String
    );
    return loginResponse;
  }
}