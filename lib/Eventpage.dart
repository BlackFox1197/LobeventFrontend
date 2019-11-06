import 'package:flutter/material.dart';
import 'package:lobevent/Models/Event.dart';
import 'package:http/http.dart' as http;

class EventList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EventListState();
  }
}

class EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('Events'),
        ),
        body: _textfield());
  }

  Widget _buildEventList() {
    return new ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return ListTile();
        });
  }

  Widget _textfield() {
    return Container(
        child: Text(http.get('https:/192.168.0.141').toString()
            //response = await http.get('https:/192.168.0.141'
            ));
  }
}
