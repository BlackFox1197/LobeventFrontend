import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Presentation/Content/Eventpage.dart';
import 'package:lobevent/Services/Communication/config.dart';

class EventCommunicator {
  Dio dio;
  static const String URL = ApiConfig.URL + ApiConfig.eventPath;

  EventCommunicator(){
    this.dio = new Dio();
  }

  /// Returns an Future of a List of all events
  /// The mapping from JSON to List of Events is done internally
  ///
  /// @return Future<List<Event>>
  ///
  Future<List<Event>> getEvents() async{
    final response = await dio.get(URL);
    List<Event> events = new List<Event>(); //init the List
    //map the date form the decoded json to an list and call Event.fromJson for each of them
    events = json.decode(response.data).map((i) => Event.fromJson(i)).toList();
    return events;
  }



}