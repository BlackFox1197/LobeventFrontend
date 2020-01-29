import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConnectionErrorWidget extends StatelessWidget {
  String httpError;
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("An  HTTP error has occured."),
        leading: MaterialButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/");
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.cyanAccent,
      ),
    );
  }
}
