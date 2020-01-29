import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lobevent/Services/Storage/LoginStorage.dart';
import 'package:lobevent/main.dart';
import 'package:lobevent/Presentation/CustomWidgets/ConnectionErrorWidget.dart';

class Communication_Base {
  Dio client;
  FlutterSecureStorage storage;
  LoginStorage ls;
  Communication_Base() {
    this.storage = new FlutterSecureStorage();
    this.ls = new LoginStorage();
    this.client = new Dio();
  }

  ///adds an security token to the request header for secure calls
  void addTokenHeader() async {
    String token = await storage.read(key: "JWT");
    this.client.options.headers["Authorization"] = "Bearer $token";
  }

  ///returns a Future of an Response generated by the [requestFunction] call
  ///intercepts on errors especially on http-status-errors
  ///[requestFunction] is a callable function which is used to call the api
  Future<Response> makeRequestAndHandleErrors(Function requestFunction) async {
    Response response;
    try {
      response = await requestFunction();
    } on DioError catch (e) {
      int statusCode = e.response.statusCode;
      switch (statusCode) {
        case 402:
          {
            ls.deleteToken();
            navigatorKey.currentState.pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
            break;
          }
        case 401:
          navigatorKey.currentState.pushNamed(
            '/httpError',
          );
          break;
        case 404:
          break;
        case 500:
          break;
      }
    }
    return response;
  }
  //dynamic HandleError(response) async
}
