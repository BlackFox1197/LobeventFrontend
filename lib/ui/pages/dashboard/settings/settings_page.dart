import 'package:auditergy_flutter/injection_container.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/measurement_tabbar_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/solar_installation_data_tabbar_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/solar_installation_messages_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/settings/settings_tabbar_widget.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPage_State createState() => SettingsPage_State();
}

class SettingsPage_State extends State<SettingsPage> {
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
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                  child: Center(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'HelveticaNeue',
                          color: ColorConstants.darkgrey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                  child: Container(
                    height: 600,
                    child: SettingsTabBarWidget(),
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
