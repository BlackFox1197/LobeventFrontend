import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorage{


  Future<bool> saveToken(String token) async{
    final storage = new FlutterSecureStorage();
    await storage.write(key: "JWT", value: token);
    String DBToken  = await storage.read(key: "JWT");
    if(DBToken == token){
      return true;
    }
    return false;

  }
}