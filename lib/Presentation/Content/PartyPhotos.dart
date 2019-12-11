import 'package:flutter/material.dart';

class PartyPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onVerticalDragUpdate: (dragUpdateDetails) {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    ));
  }
}
