import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/pages/login/login.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:auditergy_flutter/ui/widgets/photo_hero.dart';

class LandingPage extends StatelessWidget {
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
            //1. how it works introduction page
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("assets/homepage_background.jpg"),
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
                                    "Solar Dashboard Monitoring Made Easy",
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
                                    "We serve you an off-grid PV solar asset management platform,\nproviding real-time dashboard monitoring of your PV installations.",
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
                                      ;
                                    },
                                    elevation: 2.0,
                                    label: Text('GET STARTED'),
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
            //2. lets talk about solar monitoring page
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: ColorConstants.backgroundGrey,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            "Let's Talk About Solar Monitoring",
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
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 3,
                                child: Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 8,
                                        child: Container(
                                          child: Text(
                                            "As an independent solar installation owner or a Solar Provider Company, the health of your system(s) is crucial to having power when you need it.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: ColorConstants.navyBlue,
                                              fontFamily: 'HelveticaNeue',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.zero,
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(
                                                  "assets/health.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 8,
                                        child: Container(
                                          child: Text(
                                            "Solar installations do not just fail, they fail over time while giving off distress signals you cannot discern.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: ColorConstants.navyBlue,
                                              fontFamily: 'HelveticaNeue',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.zero,
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(
                                                  "assets/fail.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 8,
                                        child: Container(
                                          child: Text(
                                            "Auditergy uses Internet of Things (IoT) and Artificial Intelligence (AI) to bring you real-time sensible data about your installations and recommendations of either preventive or curative maintenance measures to ensure your systems lasts for you.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: ColorConstants.navyBlue,
                                              fontFamily: 'HelveticaNeue',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.zero,
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(
                                                  "assets/artificial_intelligence.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                      ),
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
                          (MediaQuery.of(context).size.height) * 2 + 3,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutQuint);
                    },
                  ),
                )
              ],
            ),
            //3. what we offer page
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            "Our Offerings For You",
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
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Container(),
                              ),
                              Flexible(
                                flex: 9,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Card(
                                        elevation: 4.0,
                                        color: ColorConstants.backgroundGrey,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              flex: 8,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "IoT Data Acquisition",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorConstants
                                                              .navyBlue,
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      "Our proprietary Data Acqusition Unit leverages Internet of Things technology to collect real-time system data, such as Battery Information, Power Production, Power Consumption and other necessary data from any solar installation required for a Smart Analysis of the health of that installation.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorConstants
                                                            .navyBlue,
                                                        fontFamily:
                                                            'HelveticaNeue',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        "assets/acquisition.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Card(
                                        elevation: 4.0,
                                        color: ColorConstants.backgroundGrey,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              flex: 8,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Dashboard Monitoring",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorConstants
                                                              .navyBlue,
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      "Details of all data collected in real-time is displayed intelligently and very simply on the Auditergy Dashboard. Useful for both non-technical solar installation owners, as well as for technical Solar Installation Companies or Teams.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorConstants
                                                            .navyBlue,
                                                        fontFamily:
                                                            'HelveticaNeue',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        "assets/monitoring.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 9,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Card(
                                        elevation: 4.0,
                                        color: ColorConstants.backgroundGrey,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              flex: 8,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Machine Learning as a Service",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorConstants
                                                              .navyBlue,
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      "Auditergy Intelligent Agent implements algorithms that constantly observe an installation environment using the captured data and conducts Smart Analytics on the installation.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorConstants
                                                            .navyBlue,
                                                        fontFamily:
                                                            'HelveticaNeue',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        "assets/algorithm.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Card(
                                        elevation: 4.0,
                                        color: ColorConstants.backgroundGrey,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              flex: 8,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Actionable Insights",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorConstants
                                                              .navyBlue,
                                                          fontFamily:
                                                              'HelveticaNeue',
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      "Auditergy Analytics provide both Preventive and Corrective Maintenance Action Recommendations that is crucial the overall system health and performance.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorConstants
                                                            .navyBlue,
                                                        fontFamily:
                                                            'HelveticaNeue',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        "assets/insights.png"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
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
            //4. how it looks like page
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: ColorConstants.backgroundGrey,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            "How It Looks Like",
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
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: GridView.count(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 3.0,
                            children: <Widget>[
                              Card(
                                elevation: 2.0,
                                child: Container(
                                  child: PhotoHero(
                                    photo: "assets/logo_font_white.jpeg",
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) {
                                        return Scaffold(
                                          body: Container(
                                            color:
                                                ColorConstants.backgroundGrey,
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: PhotoHero(
                                                    photo:
                                                        "assets/logo_font_white.jpeg",
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Card(
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      child: ListView(
                                                          children: <Widget>[
                                                            Text(
                                                              "Heading",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: ColorConstants
                                                                      .navyBlue,
                                                                  fontFamily:
                                                                      'HelveticaNeue',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "Description",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    ColorConstants
                                                                        .navyBlue,
                                                                fontFamily:
                                                                    'HelveticaNeue',
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: IconButton(
                                                    iconSize: 40,
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: ColorConstants
                                                          .navyBlue,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 2.0,
                                child: Container(
                                  child: PhotoHero(
                                    photo: "assets/logo_font_white.jpeg",
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) {
                                        return Scaffold(
                                          body: Container(
                                            color:
                                                ColorConstants.backgroundGrey,
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: PhotoHero(
                                                    photo:
                                                        "assets/logo_font_white.jpeg",
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Card(
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      child: ListView(
                                                          children: <Widget>[
                                                            Text(
                                                              "Heading",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: ColorConstants
                                                                      .navyBlue,
                                                                  fontFamily:
                                                                      'HelveticaNeue',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "Description",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    ColorConstants
                                                                        .navyBlue,
                                                                fontFamily:
                                                                    'HelveticaNeue',
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: IconButton(
                                                    iconSize: 40,
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: ColorConstants
                                                          .navyBlue,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 2.0,
                                child: Container(
                                  child: PhotoHero(
                                    photo: "assets/logo_font_white.jpeg",
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) {
                                        return Scaffold(
                                          body: Container(
                                            color:
                                                ColorConstants.backgroundGrey,
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: PhotoHero(
                                                    photo:
                                                        "assets/logo_font_white.jpeg",
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Card(
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      child: ListView(
                                                          children: <Widget>[
                                                            Text(
                                                              "Heading",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: ColorConstants
                                                                      .navyBlue,
                                                                  fontFamily:
                                                                      'HelveticaNeue',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "Description",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    ColorConstants
                                                                        .navyBlue,
                                                                fontFamily:
                                                                    'HelveticaNeue',
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: IconButton(
                                                    iconSize: 40,
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: ColorConstants
                                                          .navyBlue,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 2.0,
                                child: Container(
                                  child: PhotoHero(
                                    photo: "assets/logo_font_white.jpeg",
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) {
                                        return Scaffold(
                                          body: Container(
                                            color:
                                                ColorConstants.backgroundGrey,
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: PhotoHero(
                                                    photo:
                                                        "assets/logo_font_white.jpeg",
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Card(
                                                    child: Container(
                                                      color: Colors.white,
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      child: ListView(
                                                          children: <Widget>[
                                                            Text(
                                                              "Heading",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: ColorConstants
                                                                      .navyBlue,
                                                                  fontFamily:
                                                                      'HelveticaNeue',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "Description",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    ColorConstants
                                                                        .navyBlue,
                                                                fontFamily:
                                                                    'HelveticaNeue',
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: IconButton(
                                                    iconSize: 40,
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: ColorConstants
                                                          .navyBlue,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                    },
                                  ),
                                ),
                              ),
                            ],
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
            //5. service page
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
                            "Lovely Service",
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
                            "We give our best in every second to satisfy all Your needs and provide maximum value for Your energy asset management.",
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
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 60,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 60,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 60,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 60,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 60,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                                      backgroundColor: Colors.white,
                                      radius: 50,
                                    ),
                                    Text(
                                      "Test Text",
                                      style: TextStyle(
                                          color: ColorConstants.navyBlue,
                                          fontFamily: "HelveticaNeue"),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                                      backgroundColor: Colors.white,
                                      radius: 50,
                                    ),
                                    Text(
                                      "Test Text",
                                      style: TextStyle(
                                          color: ColorConstants.navyBlue,
                                          fontFamily: "HelveticaNeue"),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                                      backgroundColor: Colors.white,
                                      radius: 50,
                                    ),
                                    Text(
                                      "Test Text",
                                      style: TextStyle(
                                          color: ColorConstants.navyBlue,
                                          fontFamily: "HelveticaNeue"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                          (MediaQuery.of(context).size.height) * 5 + 3,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutQuint);
                    },
                  ),
                )
              ],
            ),
            //6. got questions page
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
                            "Got Questions?",
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
                            "For any further questions, please feel free to contact our team.\nOur team members will be pleased to help you.",
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
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                              flex: 4,
                              child: Container(
                                child: Text(
                                  "service@auditergy.com",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
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
                                  "+39 349 3445 3456",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.navyBlue,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Container(),
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
                      //get to first page
                      scrollCtrl.animateTo(
                          (MediaQuery.of(context).size.height) * 6 + 3,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutQuint);
                    },
                  ),
                )
              ],
            ),
            //7. follow us page
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
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            "Follow Us",
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
                        flex: 1,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 4,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                            ],
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
                        flex: 1,
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
                          duration: Duration(milliseconds: 3000),
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
