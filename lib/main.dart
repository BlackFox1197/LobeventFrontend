import 'package:flutter/material.dart';
import 'package:lobevent/Presentation/Content/EventSwiper.dart';
import 'package:lobevent/Presentation/Content/Eventpage.dart';
import 'package:lobevent/Presentation/Content/LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Lobevent', home: LoginScreen());
  }
}
