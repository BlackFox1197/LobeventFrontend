import 'package:dio/dio.dart';

class Communication_Base{
  Dio client;
  Communication_Base(){
    this.client = new Dio();
  }

  Future<dynamic>
}