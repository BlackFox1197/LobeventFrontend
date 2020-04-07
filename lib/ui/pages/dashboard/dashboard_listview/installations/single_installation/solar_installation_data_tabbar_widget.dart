import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/solar_installation_table_widget.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';

class SolarInstallationDataTabBarWidget extends StatelessWidget {
  // a property on this class
  final List<Map<String, dynamic>> tableObjectsList;

  final List<String> tabs = [
    "General Data",
    "Battery Pack",
    "Charge Controller",
    "Inverter",
    "Panels"
  ];

  // a constructor for this class
  SolarInstallationDataTabBarWidget(this.tableObjectsList);

  Widget build(context) {
    return new DefaultTabController(
      length: this.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Solar Installation Data"),
          backgroundColor: ColorConstants.grey,
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              for (final tab in this.tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: solarInstalationtableCard(context, tableObjectsList[0]),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: solarInstalationtableCard(context, tableObjectsList[1]),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: solarInstalationtableCard(context, tableObjectsList[2]),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: solarInstalationtableCard(context, tableObjectsList[3]),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: solarInstalationtableCard(context, tableObjectsList[4]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
