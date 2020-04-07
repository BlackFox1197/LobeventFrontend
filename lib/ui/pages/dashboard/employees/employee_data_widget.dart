import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/stacked_area_custom_color_line_chart.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/employees/employee_table_widget.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';

class EmployeeDataWidget extends StatelessWidget {
  // a property on this class
  //final Color backgroundColor;

  final List<String> tabs = ["General Data", "Assigned Installations"];

  // a constructor for this class
  //SolarInstallationMeasurementTabBarWidget();

  Widget build(context) {
    return new DefaultTabController(
      length: this.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Employee Data"),
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
                color: ColorConstants.backgroundGrey,
                child: employeeTableCard(context,
                    {"Test Key": "test value", "Test key 2": "Test value 2"}),
              ),
          ],
        ),
      ),
    );
  }
}
