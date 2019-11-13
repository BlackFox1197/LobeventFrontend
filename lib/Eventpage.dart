import 'dart:convert';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lobevent/Models/Event.dart';
import 'package:http/http.dart' as http;

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
    final response = await http.get('http://192.168.0.100:8888/events');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.

      return await EventsList.fromJson(json.decode(response.body)).events;
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
                return Text(snapshot.data.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }

  Widget _buildEventList() {
    return new ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return ListTile();
        });
  }
  /*Widget buildEventL() {
    FutureBuilder<Event>(
        future: event,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.name);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
    });
  }*/

  Widget _textfield() {
    return Container(
        child: Text(http.get('https:/192.168.0.141').toString()
            //response = await http.get('https:/192.168.0.141'
            ));
  }
}
