import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/pages/login/login.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //RESPONSIVENESS TOOL
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide <
        600; //if the shortest side is less than 600 we know that we are on a mobile device
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortraitOrientation =
        (orientation == Orientation.portrait) ? true : false;

    final ScrollController scrollCtrl = ScrollController();

    if (useMobileLayout) {
      return Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.blue,
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.green,
              ),
            )
          ],
        ),
      );
    } else if (!useMobileLayout) {
      return Container(
        child: ListView(
          controller: scrollCtrl,
          padding: const EdgeInsets.all(3.0),
          itemExtent: MediaQuery.of(context).size.height - 3,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("assets/contact.jpg"),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 4,
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    "Contact Us",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 60,
                                      color: Colors.white,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    "The Auditergy team is open for all your requests and notifications.\nWe do our best to help you and find solution for your needs.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: FloatingActionButton.extended(
                                    onPressed: () {
                                      //get to message box site
                                      scrollCtrl.animateTo(
                                          MediaQuery.of(context).size.height +
                                              3,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeOutQuint);
                                    },
                                    elevation: 2.0,
                                    label: Text('CONTACT US'),
                                    icon: Icon(Icons.play_arrow),
                                    backgroundColor: ColorConstants.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                // OVERLAYS Only for widescreen webpages -> check if screensize is wide
                //login button overlay
                Align(
                  alignment: Alignment.topRight,
                  child: Opacity(
                    opacity:
                        MediaQuery.of(context).size.width < 1300 ? 0.0 : 1.0,
                    child: Container(
                      child: ButtonBar(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print("login in pressed");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Container(
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue[300],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("signup pressed");
                            },
                            child: Container(
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green[200],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "SIGNUP",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity:
                        MediaQuery.of(context).size.width < 1300 ? 0.0 : 1.0,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      color: Colors.white,
                      iconSize: 40,
                      tooltip: 'see more',
                      onPressed: () {
                        //get to next page
                        scrollCtrl.animateTo(
                            MediaQuery.of(context).size.height + 3,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutQuint);
                      },
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: ColorConstants.backgroundGrey,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            "Get In Touch With Us",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                              color: ColorConstants.navyBlue,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Container(
                          child: Text(
                            "We're looking forward to get in touch with You!\n Feel free to write us your questions, feedback and thoughts on Auditergy.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              color: ColorConstants.navyBlue,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 10,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                              flex: 12,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    color: ColorConstants.navyBlue,
                    iconSize: 40,
                    tooltip: 'see more',
                    onPressed: () {
                      //get to next page
                      scrollCtrl.animateTo(
                          (MediaQuery.of(context).size.height) * 2 + 3,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutQuint);
                    },
                  ),
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("assets/support.jpg"),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            "Contact Us",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 60,
                              color: ColorConstants.navyBlue,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Container(
                          child: Text(
                            "You can contact us at any time via phone, via mail\nor you visited us at our place.\n You're welcome!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              color: ColorConstants.navyBlue,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 10,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                              flex: 4,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_up),
                    color: ColorConstants.navyBlue,
                    iconSize: 40,
                    tooltip: 'back to top',
                    onPressed: () {
                      //get to next page
                      scrollCtrl.animateTo(0,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeOutQuint);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }
  }
}
