import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lobevent/Presentation/Content/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenState();

  final loginNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrate'),
        leading: MaterialButton(
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                          _register();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }
                      },
                    ),
                  ],
                ),
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

  void _register() {
    String name = loginNameController.text;
    String password = passwordController.text;
    String email = emailController.text;
  }
}
