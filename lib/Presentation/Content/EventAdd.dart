import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EventAdd extends StatelessWidget {
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
          ),
          FlatButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2020, 5, 5, 20, 50),
                    maxTime: DateTime(2020, 6, 7, 05, 09), onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  print('confirm $date');
                }, locale: LocaleType.de);
              },
              child: Text(
                'setDate',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              )),
        ],
      )),
    );
  }
}
