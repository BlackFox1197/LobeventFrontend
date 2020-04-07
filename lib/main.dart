import 'package:auditergy_flutter/data/datasources/local_data_source/local_data_source.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/pages/home/home_screen.dart';
import 'package:auditergy_flutter/ui/pages/login/login.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'injection_container.dart' as di;

void main() async {
  // initialize the local data source
  LocalDataSourceImpl localDataSource = new LocalDataSourceImpl();
  await localDataSource.initializeLocalDataSource();
  //(IV) here have to check if Hive for not browser before or after init di !
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => HomeScreen(),
      '/home': (BuildContext context) => HomeScreen(),
      '/login': (BuildContext context) => Login(),
      '/dashboard': (BuildContext context) => DashboardScreen(),
    };
    return MaterialApp(
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
        fontFamily: 'HelveticaNeue',
        canvasColor: ColorConstants
            .grey, //this is going to color the drawer in both modes (small and big screen)
      ),
      debugShowCheckedModeBanner: false,
      title: 'Auditergy | Solar Dashboard Monitoring',
    );
  }
}
