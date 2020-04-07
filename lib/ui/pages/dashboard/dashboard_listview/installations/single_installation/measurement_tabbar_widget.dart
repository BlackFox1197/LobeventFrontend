import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/stacked_area_custom_color_line_chart.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';

class MeasurementTabBarWidget extends StatelessWidget {
  // a property on this class
  //final Color backgroundColor;

  final List<String> tabs = [
    "Overview",
    "Battery Charge Current",
    "Battery Discharge Current",
    "Battery Voltage",
    "Inverter Output Voltage",
    "Load Current Consumption",
    "DAQ Battery Voltage",
    "Palen Output Current",
    "Panel Output Voltage",
    "Solar Irradiance",
    "Raw Data"
  ];

  // a constructor for this class
  //SolarInstallationMeasurementTabBarWidget();

  Widget build(context) {
    return new DefaultTabController(
      length: this.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Measurement Data"),
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
            for (final tab in this.tabs)
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SizedBox(
                        height: 300,
                        child: StackedAreaCustomColorLineChart(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text("INSIGHTS"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
