import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:flutter/material.dart';

class InstallationDashboardCardWidget extends StatelessWidget {
  // a property on this class
  final String customerId;
  final String assignedEmployee;
  final String inputDCVoltage;
  final String expectedLoad;
  final String id;

  //final SolarInstallation solarInstallation;

  //give the widget only the parameters that it needs to show

  // a constructor for this class
  InstallationDashboardCardWidget({
    @required this.id,
    @required this.customerId,
    @required this.assignedEmployee,
    @required this.inputDCVoltage,
    @required this.expectedLoad,
  });

  Widget build(context) {
    return new Card(
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 2,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image(
            image: AssetImage('assets/google_maps_image.jpg'),
            fit: BoxFit.fill,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ID: ${id}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Customer ID: ${customerId}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                      Text(
                        'Assigned Employee ID: ${assignedEmployee}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                      Text(
                        'Input DC VOltage: ${inputDCVoltage}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                      Text(
                        'Expected Load: ${expectedLoad}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Status: OK",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Text(
                            "Enugu, Nigeria",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
