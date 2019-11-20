import 'package:lobevent/Data/Types/event_response.dart';
import 'package:dio/dio.dart';

class EventApiProvider{
  final String _endpoint = "http://192.168.0.100:8888/events";
  final Dio _dio = Dio();

  Future<EventResponse> getEvent() async {
    try {
      Response response = await _dio.get(_endpoint);
      return EventResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return EventResponse.withError("$error");
    }
  }
}