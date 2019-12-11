import 'dart:convert';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/Communication_Interface.dart';
import 'package:lobevent/Services/Communication/config.dart';

///Implements Methods to communicate to the Backend
class LoginCommunicator extends Communication_Base {
  static const String URL = ApiConfig.URL + ApiConfig.eventPath;
  static const String USERURL = ApiConfig.URL + ApiConfig.userEvents;

  LoginCommunicator() : super();

  void sendLogin(String name, String password) {
    //Send name and password to server
    client.post(URL, data: name);
    client.post(URL, data: password);
  }
}
