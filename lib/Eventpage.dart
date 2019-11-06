import 'package:flutter/material.dart';

class EventList extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new EventListState();
  }
}

class EventListState extends State<EventList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Events'),
      ),
      body: _buildEventList()
    );
  }
  Widget _buildEventList(){
    return new ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index){
          return ListTile(

          );
        }
    );

  }
}
