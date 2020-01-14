import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Communication_Base{
  Dio client;
  FlutterSecureStorage storage;
  Communication_Base(){
    this.storage = new FlutterSecureStorage();
    this.client = new Dio();

  }

  void addTokenHeader() async{
    String token  = await storage.read(key: "JWT");
    this.client.options.headers["Authorization"] = "Bearer $token";
  }

  //dynamic HandleError(response) async
}