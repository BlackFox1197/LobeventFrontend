import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/pages/home/about_us/about_us.dart';
import 'package:auditergy_flutter/ui/pages/home/contact/contact.dart';
import 'package:auditergy_flutter/ui/pages/home/how_it_works/how_it_works.dart';
//import 'package:website/pages/home/about_us/about_us.dart';
//import 'package:website/pages/home/contact/contact.dart';
//import 'package:website/pages/home/how_it_works/how_it_works.dart';
import 'package:auditergy_flutter/ui/pages/home/landing/landing_page.dart';
import 'package:auditergy_flutter/ui/pages/home/pricing/pricing.dart';
import 'package:auditergy_flutter/ui/pages/login/login.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int active = 0;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 5, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).size.width < 1300
            ? AppBar(
                automaticallyImplyLeading:
                    MediaQuery.of(context).size.width < 1300 ? true : false,
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          "Auditergy Logo",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HelveticaNeue',
                          ),
                        ),
                      ),
                    ]),
                actions: <Widget>[
/*             SizedBox(width: 32),
            Container(child: Icon(Icons.web)),
            SizedBox(width: 32),
            Container(child: Icon(Icons.account_circle)),
            SizedBox(width: 32),
            Container(
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ), */
                  SizedBox(width: 32),
                ],
                backgroundColor: ColorConstants.grey
                // automaticallyImplyLeading: false,
                )
            : null,
        body: Container(
          color: ColorConstants.backgroundGrey,
          child: Row(
            children: <Widget>[
              MediaQuery.of(context).size.width < 1300
                  ? Container()
                  : Card(
                      elevation: 2.0,
                      child: Container(
                          margin: EdgeInsets.all(0),
                          height: MediaQuery.of(context).size.height,
                          width: 220,
                          color: ColorConstants.grey, //ColorConstants.blue,
                          child: listDrawerItems(false)),
                    ),
              Container(
                width: MediaQuery.of(context).size.width < 1300
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width - 230,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    LandingPage(),
                    HowItWorksPage(),
                    PricingPage(),
                    AboutUsPage(),
                    ContactPage(),
                  ],
                ),
              )
            ],
          ),
        ),
        drawer: Padding(
            padding: EdgeInsets.only(top: 56),
            child: Drawer(child: listDrawerItems(true))),
        backgroundColor:
            Colors.white //background color of the whole app scaffold

        );
  }

  //coloring the drawer: https://stackoverflow.com/questions/47951907/change-flutter-drawer-background-color
  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      children: <Widget>[
        Container(
          height: 200,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              image: DecorationImage(
                image: NetworkImage("assets/logo_font_white.jpeg"),
                fit: BoxFit.cover,
              )),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("assets/logo_font_white.jpeg"),
                      backgroundColor: Colors.white,
                      radius: 0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Spacer(),
                (true)
                    ? Text(
                        "+49 168 2388 328",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
                (true)
                    ? Text(
                        "service@auditergy.com",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 0
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(0);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.home,
                    color: tabController.index == 0
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "HOME",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 0
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 1
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            print(tabController.index);
            tabController.animateTo(1);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.settings,
                    color: tabController.index == 1
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "HOW IT WORKS",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 1
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 2
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            tabController.animateTo(2);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.monetization_on,
                    color: tabController.index == 2
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "PRICING",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 2
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 3
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            tabController.animateTo(3);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.apps,
                    color: tabController.index == 3
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "ABOUT US",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 3
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 4
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            tabController.animateTo(4);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.assignment_ind,
                    color: tabController.index == 4
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "CONTACT",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 4
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        Opacity(
          opacity: MediaQuery.of(context).size.width < 1300 ? 1.0 : 0.0,
          child: FlatButton(
            color: ColorConstants.blue,
            onPressed: () {
              //login
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
                child: Row(children: [
                  Icon(Icons.input, color: ColorConstants.lightgrey),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'HelveticaNeue',
                        color: ColorConstants.ultralightgrey),
                  ),
                ]),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: MediaQuery.of(context).size.width < 1300 ? 1.0 : 0.0,
          child: FlatButton(
            color: ColorConstants.green,
            onPressed: () {
              // go to signup
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
                child: Row(children: [
                  Icon(Icons.assignment_turned_in,
                      color: ColorConstants.lightgrey),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "SIGNUP",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'HelveticaNeue',
                        color: ColorConstants.ultralightgrey),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
