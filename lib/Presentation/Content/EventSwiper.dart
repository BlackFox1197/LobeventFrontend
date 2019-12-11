import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lobevent/Business/EventResponseFunctions.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Presentation/Content/EventsSigned.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';
import 'EventAdd.dart';
import 'MyEvents.dart';
import 'PartyPhotos.dart';

class EventSwiper extends StatefulWidget {
  @override
  EventSwiperState createState() => EventSwiperState();
}

class EventSwiperState extends State<EventSwiper> {
  EventSwiperState() {
    communicator = new EventCommunicator();
    eventsFutures = communicator.get();
    ERfunctions = new EventResponseFunctions();
  }
  EventResponseFunctions ERfunctions;
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

  void sendResponse(int state){
    ERfunctions.sendEventResponse(state, activeData.id);
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
              if(eventlist == null){
                return noContentLeft();
              }
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
                child: Icon(Icons.face),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyEvents())
                  );
                },

              ),
              FloatingActionButton(
                heroTag: 'btn3',
                child: Icon(Icons.thumb_up),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventsSigned())
                  );
                },

              ),
              GestureDetector(
              onVerticalDragUpdate: (dragUpdateDetails) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PartyPhotos())
                );
            },
              ),
    ]));
  }

  Widget getContent() {
    return Center(
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
                                sendResponse(1);
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
                                sendResponse(0);
                                activeData = next();
                              });
                            },
                          )
                        ]))));
  }

  Widget noContentLeft(){
    return Center(
      child: Text("no Events Left"),
    );
  }
}
