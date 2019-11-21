/*import 'dart:convert';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class EventList extends StatefulWidget {
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  Future<List<Event>> event;

  @override
  void initState() {
    super.initState();
    event = fetchPost();
  }

  Future<List<Event>> fetchPost() async {
    var dio = Dio();
    final response = await http.get('http://192.168.0.100:8888/events');

      // If server returns an OK response, parse the JSON.

      return EventsList.fromJson(json.decode(response.body)).events;
      // If server returns an OK response, parse the JSON.
      //return Event.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
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
