import 'dart:convert';
import 'package:lobevent/Data/Types/Response/LoginResponse.dart';
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
    loginStorage : new LoginStorage();
    return LoginCommunicator._();
  }

  LoginCommunicator._() : super();

  Future<bool> sendLogin(String name, String password) async{
    //Send name and password to server

    new User(name, password);
    final response = await client.post(URL, data: User(name, password));
    final loginResponse = LoginResponse.fromJSON(json.decode(response.data));
    final Future<bool> success = this.loginStorage.saveToken(loginResponse.token);
    return success;

  }
}
