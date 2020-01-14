import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lobevent/Business/EventResponseFunctions.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Presentation/Content/EventsSigned.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';
import 'package:lobevent/main.dart';
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
    if(eventlist != null)
      activeData = eventlist[0];
  }

  Event next() {
    return eventlist.removeAt(0);
  }

  void sendResponse(int state) {
    ERfunctions.sendEventResponse(state, activeData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        FutureBuilder<List<Event>>(
            future: eventsFutures,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                init1(snapshot.data);
                if (eventlist == null) {
                  return noContentLeft();
                }
                return getContentEventCard();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }),
        Positioned(
          bottom: 10,
          left: MediaQuery.of(context).size.width / 2 - 28,
          child: Column(
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'btn1',
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EventAdd()));
                },
              ),
              FloatingActionButton(
                heroTag: 'btn2',
                child: Icon(Icons.face),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyEvents()));
                },
              ),
              FloatingActionButton(
                heroTag: 'btn3',
                child: Icon(Icons.thumb_up),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EventsSigned()));
                },
              ),
              FloatingActionButton(
                heroTag: 'btn4',
                child: Icon(Icons.ac_unit),
                onPressed: () {
                  navigatorKey.currentState.pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                }
              ),
            ],
          ),
        ),
      ]),
      /*GestureDetector(
            onVerticalDragUpdate: (dragUpdateDetails) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PartyPhotos()));
            },
          ),
           */
    );
  }

  Widget getContentEventCard() {
    return Card(
        color: Colors.blueAccent,
        child: Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  activeData.name,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.75,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  activeData.date.toString(),
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                ButtonYesNoRow(),
              ]),
        ));
  }

  Widget ButtonYesNoRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
        ),
      ],
    );
  }

  Widget noContentLeft() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blueAccent,
      alignment: Alignment.center,
      child: Text("no Events Left"),
    ));
  }
}
