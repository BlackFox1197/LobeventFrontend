import 'package:flutter/material.dart';
import 'package:lobevent/Business/EventFunctions.dart';
import 'package:lobevent/Data/Types/Event.dart';

class MyEvents extends StatelessWidget {
  MyEvents() {
    eventFunctions = new EventFunctions();
    eventsFutures = eventFunctions.getOwnedUserEvents();
  }
  EventFunctions eventFunctions;
  Future<List<Event>> eventsFutures;
  List<Event> items;

  init1(List<Event> events) {
    items = events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyEvents'),
          leading: MaterialButton(
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),

        ),
        body: Container(
            child: FutureBuilder<List<Event>>(
                future: eventsFutures,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    init1(snapshot.data);
                    return getContent();
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                })));
  }

  Widget getContent() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(

          title: Text(items[index].name)

        );
      },
    );
  }
}
