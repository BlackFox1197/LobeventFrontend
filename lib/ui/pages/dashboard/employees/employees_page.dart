import 'package:auditergy_flutter/ui/pages/dashboard/employees/employee_dashboard_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:auditergy_flutter/ui/utils/raw_data.dart';
import 'package:auditergy_flutter/ui/widgets/ticket_cards.dart';

class EmployeesPage extends StatefulWidget {
  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Stack(
      children: [
        CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Column(
                    children: <Widget>[
                      MediaQuery.of(context).size.width < 1300
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                tickets(Colors.pink, context, Icons.sms_failed,
                                    "3", "New Failures", "Failures"),
                                tickets(
                                    Colors.amber,
                                    context,
                                    Icons.track_changes,
                                    "5",
                                    "New Warnings",
                                    "Warnings"),
                                tickets(
                                    Colors.teal,
                                    context,
                                    Icons.question_answer,
                                    "8",
                                    "New Messages",
                                    "Messages"),
                                tickets(Colors.lightBlue, context, Icons.sort,
                                    "2", "New Insights", "Insights"),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                tickets(Colors.pink, context, Icons.sms_failed,
                                    "3", "New Failures", "Failures"),
                                tickets(
                                    Colors.amber,
                                    context,
                                    Icons.track_changes,
                                    "5",
                                    "New Warnings",
                                    "Warnings"),
                                tickets(
                                    Colors.teal,
                                    context,
                                    Icons.question_answer,
                                    "8",
                                    "New Messages",
                                    "Messages"),
                                tickets(Colors.lightBlue, context, Icons.sort,
                                    "2", "New Insights", "Insights"),
                              ],
                            ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).size.width > 1300 ? 4 : 3,
                childAspectRatio:
                    MediaQuery.of(context).size.width < 1300 ? 0.6 : 0.65,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildListDelegate(
                [
                  EmployeeDashboardCardWidget("test"),
                  EmployeeDashboardCardWidget("test"),
                  EmployeeDashboardCardWidget("test"),
                  EmployeeDashboardCardWidget("test"),
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.lightBlue,
              tooltip: "Add Employee",
            ),
          ),
        ),
      ],
    );
  }
}
