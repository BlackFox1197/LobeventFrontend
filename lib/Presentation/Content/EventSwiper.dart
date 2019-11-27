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
    activeData = cards.removeAt(0).toString();
  }
  List cards = new List.generate(20, (i) => (new Random()).nextInt(1000)).toList();
  String activeData;

  String next() {
    return cards.removeAt(0).toString();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          child:  Card(
            color: Colors.blueAccent,
            child: Container(
              width: 300,
              height: 400,
              child: MaterialButton(
                child: Text(activeData),
                onPressed: () {
                  setState(() {
                    activeData = next();
                  });
                },
              ),
          )
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
