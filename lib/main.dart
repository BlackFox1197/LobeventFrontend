import 'package:flutter/material.dart';
import 'package:lobevent/Presentation/Content/EventSwiper.dart';
import 'package:lobevent/Presentation/Content/LoginScreen.dart';
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lobevent',
        initialRoute: '/',
        routes: {
          '/' :(context) => SafeArea(
            child: EventSwiper(),
          ),
          '/login' : (context) => SafeArea(
            child: LoginScreen(),
          )
        },
      navigatorKey: navigatorKey,
    );
  }
}
