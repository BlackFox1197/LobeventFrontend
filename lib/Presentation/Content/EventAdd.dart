import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EventAdd extends StatelessWidget {
  String eventName;
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
            onSaved: (String value) {
              eventName = value;
            },
          ),
          SizedBox(
              width: double.infinity,
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2020, 5, 5, 20, 50),
                        maxTime: DateTime(2020, 6, 7, 05, 09),
                        onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, locale: LocaleType.de);
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'setDate',
                        style: TextStyle(color: Colors.grey),
                      )))),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {

            },
          )
        ],
      )),
    );
  }
}
