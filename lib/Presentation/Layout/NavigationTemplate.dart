import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationTemplate extends StatefulWidget {
  Widget child;
  NavigationTemplate({this.child});
  @override
  State<StatefulWidget> createState() =>
      NavigationTemplateState(child: this.child);
}

class NavigationTemplateState extends State<NavigationTemplate> {
  Widget child;
  NavigationTemplateState({this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.indigoAccent,
      leading: Icon(Icons.settings),
      title: Text("lobevent"),
    );
  }
}
