import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/pages/login/login.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';

class PricingPage extends StatelessWidget {
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
            //1. pricing introduction page
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("assets/pricing.jpg"),
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
                                    "Rates & Charges",
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
                                    "We commit us to transparent pricing and low fees.\nApplying for a subscription is free as well as basic services.\nIndividual contracts for higher demands are possible.",
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
                                    label: Text('SEE PRICES'),
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
            //2. pricing page
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
                            "Our Price Offerings",
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.white,
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
            //3. packet content page
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
                            "What Is Included",
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Card(
                                elevation: 4.0,
                                color: Colors.blue,
                                child: Container(
                                  color: Colors.white,
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
            //4. FAQ page
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
                            "Frequently Asked Questions",
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
                            "You are still looking for answers?\nHere is a collection of our most asked questions.",
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
                              child: Column(
                                children: <Widget>[
                                  Flexible(
                                    flex: 12,
                                    child: Column(
                                      children: <Widget>[
                                        ExpansionTile(
                                          title: Text(
                                            "What are my payment methods?",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: ColorConstants.navyBlue,
                                              fontFamily: 'HelveticaNeue',
                                            ),
                                          ),
                                          children: <Widget>[
                                            Text(
                                              "Payment methods for the service are Credit Card and PayPal.",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstants.navyBlue,
                                                fontFamily: 'HelveticaNeue',
                                              ),
                                            )
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text(
                                            "Is there an app for mobile?",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: ColorConstants.navyBlue,
                                              fontFamily: 'HelveticaNeue',
                                            ),
                                          ),
                                          children: <Widget>[
                                            Text(
                                              "Yes, Auditergy apps exist for iOS, Android as well as MacOS and Windows.",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstants.navyBlue,
                                                fontFamily: 'HelveticaNeue',
                                              ),
                                            )
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text(
                                            "How can I register?",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: ColorConstants.navyBlue,
                                              fontFamily: 'HelveticaNeue',
                                            ),
                                          ),
                                          children: <Widget>[
                                            Text(
                                              "Signup up is possible by clicking the green button on top of the screen.",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstants.navyBlue,
                                                fontFamily: 'HelveticaNeue',
                                              ),
                                            )
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text(
                                            "How can I buy the Data Aquisition Units?",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: ColorConstants.navyBlue,
                                              fontFamily: 'HelveticaNeue',
                                            ),
                                          ),
                                          children: <Widget>[
                                            Text(
                                              "Data Aquisition Units can be bought in our market. You will have access after login in.",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: ColorConstants.navyBlue,
                                                fontFamily: 'HelveticaNeue',
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
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
            //5. got questions page
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
