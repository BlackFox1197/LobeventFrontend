import 'package:auditergy_flutter/injection_container.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/my_account/my_profile_page.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/single_installation_page.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/employees/employees_page.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/create_installation/create_installation_page.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/employees/single_employee_page.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/market/market_page.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/dashboard.dart';
import 'package:auditergy_flutter/ui/pages/login/login.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  SidebarBloc _sidebarBloc;
  TabController tabController;
  int active = 0;
  @override
  void initState() {
    super.initState();
    _sidebarBloc = sl<SidebarBloc>();
    tabController = new TabController(vsync: this, length: 5, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SidebarBloc>(
          builder: (_) => _sidebarBloc,
        ),
      ],
      child: Scaffold(
          appBar: MediaQuery.of(context).size.width < 1300
              ? AppBar(
                  automaticallyImplyLeading:
                      MediaQuery.of(context).size.width < 1300 ? true : false,
                  title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            "", //Put LOGO here or something similar
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaNeue',
                            ),
                          ),
                        ),
                      ]),
                  actions: <Widget>[
                    SizedBox(width: 32),
                  ],
                  backgroundColor: ColorConstants.grey //ColorConstants.blue,
                  // automaticallyImplyLeading: false,
                  )
              : null,
          body: Container(
            color: ColorConstants.backgroundGrey,
            child: Row(
              children: <Widget>[
                MediaQuery.of(context).size.width < 1300
                    ? Container()
                    : Card(
                        elevation: 2.0,
                        child: Container(
                            margin: EdgeInsets.all(0),
                            height: MediaQuery.of(context).size.height,
                            width: 220,
                            color: ColorConstants.grey, //ColorConstants.blue,
                            child: listDrawerItems(false)),
                      ),
                Container(
                  width: MediaQuery.of(context).size.width < 1300
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width - 230,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      Dashboard(),
                      EmployeesPage(),
                      MarketPage(),
                      SettingsPage(),
                      MyProfilePage(),
                    ],
                  ),
                )
              ],
            ),
          ),
          drawer: Padding(
              padding: EdgeInsets.only(top: 56),
              child: Drawer(child: listDrawerItems(true))),
          backgroundColor:
              Colors.white //background color of the whole app scaffold
          ),
    );
  }

  //coloring the drawer: https://stackoverflow.com/questions/47951907/change-flutter-drawer-background-color
  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      children: <Widget>[
        BlocBuilder<SidebarBloc, SidebarState>(
          builder: (context, state) {
            if (state is SidebarUninitializedState) {
              dispatchInitializeSidebarEvent(context);
              return Center(
                child: Text("Initializing ..."),
              );
            }
            if (state is SidebarLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SidebarErrorState) {
              return Center(
                child: Text("Error: " + state.errorMessage),
              );
            }
            if (state is SidebarInitializedState) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://backgrounddownload.com/wp-content/uploads/2018/09/google-material-design-background-6.jpg"),
                      fit: BoxFit.cover,
                    )),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI4JuatGP6M5_Q0wYSkx2jAVzJff1FBaPYXV7zFbMngh5RV6J7"),
                            backgroundColor: Colors.white,
                            radius: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width > 1300
                                ? 20
                                : 0,
                          ),
                          (MediaQuery.of(context).size.width > 1300)
                              ? Text(state.currentUser.firstname +
                                  " " +
                                  state.currentUser.lastname)
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.width > 1300 ? 20 : 0,
                      ),
                      Spacer(),
                      (MediaQuery.of(context).size.width > 1300)
                          ? Text(
                              state.currentUser.firstname +
                                  " " +
                                  state.currentUser.lastname,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(),
                      (MediaQuery.of(context).size.width > 1300)
                          ? Text(
                              state.currentUser.email,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        FlatButton(
          color: tabController.index == 0
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(0);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.home,
                    color: tabController.index == 0
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "DASHBOARD",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 0
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 1
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            tabController.animateTo(1);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.apps,
                    color: tabController.index == 1
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "EMPLOYEES",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 1
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 2
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            tabController.animateTo(2);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.assignment_ind,
                    color: tabController.index == 2
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "MARKET",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 2
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 3
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            tabController.animateTo(3);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.assignment_ind,
                    color: tabController.index == 3
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "SETTINGS",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 3
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 4
              ? ColorConstants.darkgrey
              : ColorConstants.grey,
          onPressed: () {
            tabController.animateTo(4);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.verified_user,
                    color: tabController.index == 4
                        ? ColorConstants.lightblue
                        : ColorConstants.lightgrey),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "MY PROFILE",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: tabController.index == 4
                          ? Colors.white
                          : ColorConstants.ultralightgrey),
                ),
              ]),
            ),
          ),
        ),
        Opacity(
          opacity: MediaQuery.of(context).size.width < 1300 ? 1.0 : 1.0,
          child: FlatButton(
            color: ColorConstants.blue,
            onPressed: () {
              //TODO: call Logout Usecase
              Navigator.pushNamed(context, '/login');
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
                child: Row(children: [
                  Icon(Icons.input, color: ColorConstants.lightgrey),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "LOGOUT",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'HelveticaNeue',
                        color: ColorConstants.ultralightgrey),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void dispatchInitializeSidebarEvent(context) {
    BlocProvider.of<SidebarBloc>(context).dispatch(InitializeSidebarEvent());
  }
}
