import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/pages/login/login.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';

class AboutUsPage extends StatelessWidget {
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
            //1. about us introduction page
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("assets/about_us.jpg"),
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
                                    "About Us",
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
                                    "Auditergy serves you with a platform for solar dashboard monitoring.\nWe use IoT technology to help you getting the maximum\nvalue out of your renewable assets.",
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
                                      // Add your onPressed code here!
                                    },
                                    elevation: 2.0,
                                    label: Text('WATCH VIDEO'),
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
            //2. what we stand for page
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
                            "What Auditergy Stands For",
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
                            "All our decisions at Auditergy are driven by our four core values.\n They provide a direction for everything we do.",
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
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
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
            //3. team photo page
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
                        flex: 1,
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
                          (MediaQuery.of(context).size.height) * 3 + 3,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutQuint);
                    },
                  ),
                )
              ],
            ),
            //4. team introduction page
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
                            "Team",
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
                            "Great service for our customers starts with a great team. Our team members\n are interdisciplinary and have an open ear for\n all of your questions.",
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
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
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
                          (MediaQuery.of(context).size.height) * 4 + 3,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutQuint);
                    },
                  ),
                )
              ],
            ),
            //5. partnerships page
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.white,
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
                            "Partnerships",
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
                            "We are proud to have amazing partners in industry leading companies.\n They enable us to grow and serve with our best.\n Thank you for all.",
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
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.green,
                                ),
                              ),
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
                          duration: Duration(milliseconds: 2000),
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
