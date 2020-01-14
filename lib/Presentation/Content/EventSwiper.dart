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

  ///initializes the eventList
  ///[events] is a list of events to initialize the class eventlist
  initEventList(List<Event> events) {
    eventlist = events;
    if (eventlist != null) activeData = eventlist[0];
  }

  ///returns an new enventlist with the current element removed
  Event next() {
    return eventlist.removeAt(0);
  }

  void sendResponse(int state) {
    ERfunctions.sendEventResponse(state, activeData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:_buildScrollable(context),
      )
    );
  }

  Widget _buildScrollable(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Stack(children: <Widget>[
            FutureBuilder<List<Event>>(
                future: eventsFutures,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    initEventList(snapshot.data);
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventsSigned()));
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('Grid Item $index'),
              );
            },
            childCount: 20,
          ),
        )
      ],
    );
  }

  ///returns an Widget with the current eventcard content
  Widget getContentEventCard() {
    return Card(
        color: Colors.blueAccent,
        child: Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.9,
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

  ///return an row with the yes or no Buttons
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

  ///return a widget for showing, if no content is left on the swiper
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
