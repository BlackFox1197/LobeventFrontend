import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lobevent/Presentation/Content/EventSwiper.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginScreenState();

  final loginNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.cyanAccent,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Enter your username:'),
                  controller: loginNameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your Password'),
                  controller: passwordController,
                ),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 50,
                      height: 20,
                      color: Colors.amber,
                      child: Text('Login'),
                      onPressed: () {
                        _login();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventSwiper()));
                      },
                    ),
                    MaterialButton(
                      minWidth: 50,
                      height: 20,
                      color: Colors.brown,
                      child: Text('Registrate'),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    String name = loginNameController.text;
    String password = passwordController.text;
  }
}
