/*
import 'dart:convert';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';

class EventList extends StatefulWidget {
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  Future<List<Event>> event;
  int eventIndex = 0;

  void eventIndexIncrement() {
    eventIndex = eventIndex + 1;
  }

  int eventIndexGet() {
    return eventIndex;
  }

  @override
  void initState() {
    super.initState();
    event = fetchPost();
  }

  Future<List<Event>> fetchPost() async {
    var dio = Dio();
   final response = await http.get('http://192.168.0.100:8888/events');
   //List<dynamic> r = (json.decode(response.body));
  // List<Event> d = r.map((i) => Event.fromJson(i)).toList();
      // If server returns an OK response, parse the JSON.
    return await (new EventCommunicator()).get();
    //return d;
      // If server returns an OK response, parse the JSON.
      //return Event.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('Events'),
        ),
        body: FutureBuilder<List<Event>>(
            future: event,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data[0].name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }
}
*/

