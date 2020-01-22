import 'package:lobevent/Data/Types/Token.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/config.dart';
import 'package:lobevent/Data/Types/User.dart';
import 'package:lobevent/Services/Storage/LoginStorage.dart';

///Implements Methods to communicate to the Backend
class LoginCommunicator extends Communication_Base {
  static const String URL = ApiConfig.URL + ApiConfig.loginPath;
  LoginStorage loginStorage;

  factory LoginCommunicator(){
    LoginStorage loginStorage = new LoginStorage();
    return LoginCommunicator._(loginStorage: loginStorage);
  }

  LoginCommunicator._({this.loginStorage}) : super();

  ///send an login Request to the server
  ///[name] is an login name and [password] is the password of the user
  Future<bool> sendLogin(String name, String password) async{
    //Send name and password to server
    final User user =new User(name, password);
    final response = await client.post(URL, data: user.toLoginJson());
    final loginResponse = Token.fromJSON(response.data);
    final bool success = await this.loginStorage.saveToken(loginResponse.token);
    return success;

  }
}
