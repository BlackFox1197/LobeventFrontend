import 'package:flutter/material.dart';

class NavigationTemplate extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Widget appBar;
  NavigationTemplate({this.child, this.currentIndex, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(

            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, "/addEvent"),
            ),//new Icon(Icons.add),
            title: new Text('Add'),

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }

  Widget getAppBar() {
    if(appBar != null){
      return appBar;
    }
    return AppBar(
      backgroundColor: Colors.indigoAccent,
      leading: Icon(Icons.settings),
      title: Text("lobevent"),
    );
  }
}
