import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lobevent/Services/Communication/LoginCommunicator.dart';

class LoginManager{
  Future<bool> checkForToken() async{
    final storage = new FlutterSecureStorage();
    String DBToken  = await storage.read(key: "JWT");
    if(DBToken != null){
      return true;
    }
    return false;
  }
}