class Token {
  String token;


  Token({this.token});

  factory Token.fromJSON(Map<String, dynamic> json){
    final token = Token(
      token : json['token'] as String
    );
    return token;
  }
}