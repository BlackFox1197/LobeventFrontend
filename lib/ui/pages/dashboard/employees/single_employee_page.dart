import 'package:auditergy_flutter/injection_container.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/measurement_tabbar_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/solar_installation_data_tabbar_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/solar_installation_messages_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/employees/employee_data_widget.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleEmployeePage extends StatefulWidget {
  @override
  SingleEmployeePage_State createState() => SingleEmployeePage_State();
}

class SingleEmployeePage_State extends State<SingleEmployeePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 16.0),
                  child: Container(
                    height: 300,
                    //color: Colors.back,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                        backgroundColor: Colors.white,
                        radius: 150,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                  child: Center(
                    child: Text(
                      "Paul Exampleman",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'HelveticaNeue',
                          color: ColorConstants.darkgrey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Status: IN WORK",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Text(
                            "Employee ID: 12323494350",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                  child: Container(
                    height: 600,
                    child: EmployeeDataWidget(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: null,
                            child: Text('Update Employee Data',
                                style: TextStyle(fontSize: 20)),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text('Delete Employee',
                                style: TextStyle(fontSize: 20)),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text('Assign Installation',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
