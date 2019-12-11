import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lobevent/Business/EventFunctions.dart';
import 'package:lobevent/Data/Types/Event.dart';

class EventAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddEventState();
}

class _AddEventState extends State<EventAdd> {
  DateTime date;

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EventAdd'),
        leading: MaterialButton(
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter EventName'),
            controller: _nameController,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2019, 5, 5, 20, 50),
                        maxTime: DateTime(2050, 6, 7, 05, 09),
                        onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      this.date = date;
                      print('confirm $date');
                    }, locale: LocaleType.de);
                  },
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Datum',
                        style: TextStyle(color: Colors.grey),
                      )))),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _addEvent();
            },
          )
        ],
      )),
    );
  }

  void _addEvent() {
    String eventName = _nameController.text;
    Event event = new Event();
    event.date = date;
    event.name = eventName;
    EventFunctions eventFunctions = new EventFunctions();
    eventFunctions.addEvent(event);
  }
}
