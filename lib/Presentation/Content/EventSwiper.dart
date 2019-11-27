import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';

class EventSwiper extends StatefulWidget {
  @override
  EventSwiperState createState() => EventSwiperState();
}

class EventSwiperState extends State<EventSwiper> {

  EventSwiperState(){
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
    return  Scaffold(
      body: FutureBuilder<List<Event>>(
        future: eventsFutures,
        builder: (context, snapshot){
            if(snapshot.hasData){
              init1(snapshot.data);
              return getContent();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
      }
    )
    );
  }

  Widget getContent(){
    return Container(
        child:  Card(
            color: Colors.blueAccent,
            child: Container(
              width: 300,
              height: 400,
              child: MaterialButton(
                child: Text(activeData.name),
                onPressed: () {
                  setState(() {
                    activeData = next();
                  });
                },
              ),
            )
        )
    );
  }
}

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Card(
            child: Card(
              color: Colors.blueAccent,
              child: Container(
                width: 300,
                height: 400,
                child: MaterialButton(
                  child: Text( 'Next Event' ),
                  onPressed: () {

                  },
                ),
              ),
            ),
   );

  }
}
