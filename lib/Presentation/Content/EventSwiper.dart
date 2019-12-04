import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';
import 'EventAdd.dart';
import 'MyEvents.dart';

class EventSwiper extends StatefulWidget {
  @override
  EventSwiperState createState() => EventSwiperState();
}

class EventSwiperState extends State<EventSwiper> {
  EventSwiperState() {
    communicator = new EventCommunicator();
    eventsFutures = communicator.get();
  }
  EventCommunicator communicator;
  Future<List<Event>> eventsFutures;
  List<Event> eventlist;
  Event activeData;

  init1(List<Event> events) {
    eventlist = events;
    activeData = eventlist[0];
  }

  Event next() {
    return eventlist.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: <Widget>[
            FutureBuilder<List<Event>>(
              future: eventsFutures,
              builder: (context, snapshot) {
            if (snapshot.hasData) {
              init1(snapshot.data);
              return getContent();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
              FloatingActionButton(
                heroTag: 'btn1',
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventAdd())
                  );
                },

              ),
              FloatingActionButton(
                heroTag: 'btn2',
                child: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyEvents())
                  );
                },

              )
    ]));
  }

  Widget getContent() {
    return Center(
        child: Container(
            child: Card(
                color: Colors.blueAccent,
                child: Container(
                    width: 300,
                    height: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(activeData.name),
                          MaterialButton(
                            color: Colors.red,
                            child: Icon(Icons.delete),
                            height: 40.0,
                            minWidth: 70.0,
                            onPressed: () {
                              setState(() {
                                activeData = next();
                              });
                            },
                          ),
                          MaterialButton(
                            color: Colors.green,
                            child: Icon(Icons.add_circle),
                            height: 40.0,
                            minWidth: 70.0,
                            onPressed: () {
                              setState(() {
                                activeData = next();
                              });
                            },
                          )
                        ])))));
  }
}
