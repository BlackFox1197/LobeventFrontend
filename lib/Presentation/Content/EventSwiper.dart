import 'package:flutter/material.dart';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';

class EventSwiper extends StatefulWidget {
  @override
  EventSwiperState createState() => EventSwiperState();
}

class EventSwiperState extends State<EventSwiper> {
  List cards =new List.generate(20, (i) => new CustomCard()).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Stack(
            children: cards,
          )

        )

    );

  }
}

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Card(
        child: Positioned(
            top: 150,
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
          )
   );

  }
}
