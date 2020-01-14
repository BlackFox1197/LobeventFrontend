import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Communication_Base{
  Dio client;
  FlutterSecureStorage storage;
  Communication_Base(){
    this.storage = new FlutterSecureStorage();
    Future<String> token = this.getToken();
    this.client = new Dio();

    this.client.options.headers["Authorization"] = "Bearer $token";
  }

  Future<String> getToken()async{
    String DBToken  = await storage.read(key: "JWT");
    return DBToken;
  }

  //dynamic HandleError(response) async
}