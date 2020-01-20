import 'package:flutter/material.dart';
import 'package:lobevent/Presentation/Content/EventAdd.dart';
import 'package:lobevent/Presentation/Content/Feed.dart';
import 'package:lobevent/Presentation/Content/LoginScreen.dart';
import 'package:lobevent/Presentation/CustomWidgets/RouteBackAppBar.dart';

import 'Presentation/Layout/NavigationTemplate.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lobevent',
      initialRoute: '/',
      routes: {
        '/': (context) => NavigationTemplate(
              child: Feed(),
              currentIndex: 0,
            ),
        '/login': (context) => SafeArea(
              child: LoginScreen(),
            ),
        '/addEvent': (context) => NavigationTemplate(
              currentIndex: 1,
              appBar: RouteBackAppBar(title: "Add Event", context: context,),
              child: EventAdd(),
            ),
      },
      navigatorKey: navigatorKey,
    );
  }
}
