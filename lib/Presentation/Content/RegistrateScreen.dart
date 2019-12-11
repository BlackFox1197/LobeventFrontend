import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lobevent/Presentation/Content/LoginScreen.dart';

class RegistrateScreen extends StatefulWidget {
  @override
  RegistrateScreenState createState() => RegistrateScreenState();
}

class RegistrateScreenState extends State<RegistrateScreen> {
  RegistrateScreenState();

  final loginNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.cyanAccent,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                    heroTag: 'btn0',
                    splashColor: Colors.cyanAccent,
                    child: Icon(Icons.arrow_left),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Enter your username:'),
                  controller: loginNameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your Password'),
                  controller: passwordController,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Enter your Password again'),
                  controller: confirmPasswordController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your e-mail'),
                  controller: emailController,
                ),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 50,
                      height: 20,
                      color: Colors.amber,
                      child: Text('Registrate'),
                      onPressed: () {
                        if (loginNameController.text == null ||
                            passwordController.text == null ||
                            loginNameController.text.length == 0 ||
                            passwordController.text.length == 0 ||
                            passwordController.text !=
                                confirmPasswordController.text ||
                            emailController.text.length == 0) {
                          falseInputs();
                        } else {
                          _registrate();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //TODO; catch false Inputs
  void falseInputs() {
    Widget build(BuildContext context) {
      return Center(child: Text('Please input name and password.'));
    }
  }

  void _registrate() {
    String name = loginNameController.text;
    String password = passwordController.text;
    String email = emailController.text;
  }
}
