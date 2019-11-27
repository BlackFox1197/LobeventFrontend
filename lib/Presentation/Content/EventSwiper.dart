import 'package:flutter/material.dart';
import 'package:lobevent/Data/Types/event_list.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';
import 'package:lobevent/Data/Types/Event.dart';

class EventSwiper extends StatelessWidget {
  List cards = new List.generate(20, (i) => new CustomCard());
  Future<List<Event>> EventListFuture = EventCommunicator().get();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(child: Stack(children: [])),
    );
  }
}

class CustomCard extends StatelessWidget {

  List<Event> getEventList {
    FutureBuilder<List<Event>>(
  future: EventList,
  builder: (context,snapshot){
    EventList<Event>=snapshot.data ??[];
  }
  )
    return EventList;
}
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Positioned(
      top: 150,
      child: Card(
        color: Colors.blueAccent,
        child: Container(
          child: Text(EventSwiper().EventList)
          width: 300,
          height: 400,
          child: MaterialButton(
            child: Text('Next Event'),
            onPressed: () {},
          ),
        ),
      ),
    ));
  }
}
