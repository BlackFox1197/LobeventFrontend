import 'dart:convert';
import 'package:lobevent/Data/Types/Token.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/Communication_Interface.dart';
import 'package:lobevent/Services/Communication/config.dart';
import 'package:lobevent/Data/Types/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    new User(name, password);
    print((User(name, password)).toJson());
    final response = await client.post(URL, data: (User(name, password)).toJson());
    final loginResponse = Token.fromJSON(response.data);
    final bool success = await this.loginStorage.saveToken(loginResponse.token);
    return success;

  }
}
