import 'package:auditergy_flutter/injection_container.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/create_installation/create_installation_page.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/installation_dashboard_card_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/single_installation_page.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/widgets/ticket_cards.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _formKey = GlobalKey<FormState>();
  DashboardBloc _dashboardBloc;

  @override
  initState() {
    _dashboardBloc = sl<DashboardBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      builder: (_) => _dashboardBloc,
      child:
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
        if (state is DashboardUninitializedState) {
          dispatchInitializeDashboardEvent(context);
          return Center(
            child: Text("Initializing ..."),
          );
        }
        if (state is DashboardLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DashboardErrorState) {
          return Center(
            child: Text("Error: " + state.errorMessage),
          );
        }
        if (state is DashboardInitializedState) {
          //dispatchInitializeSolarInstallationFormEvent(context);
          return Scaffold(
            backgroundColor: ColorConstants.backgroundGrey,
            body: Stack(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                          tickets(
                                              Colors.red,
                                              context,
                                              Icons.sms_failed,
                                              "3",
                                              "New Failures",
                                              "Failures"),
                                          tickets(
                                              Colors.orange,
                                              context,
                                              Icons.track_changes,
                                              "5",
                                              "New Warnings",
                                              "Warnings"),
                                          tickets(
                                              Colors.lightBlue,
                                              context,
                                              Icons.question_answer,
                                              "8",
                                              "New Messages",
                                              "Messages"),
                                          tickets(
                                              Colors.indigo,
                                              context,
                                              Icons.sort,
                                              "2",
                                              "New Insights",
                                              "Insights"),
                                        ])
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                          tickets(
                                              Colors.red,
                                              context,
                                              Icons.sms_failed,
                                              "3",
                                              "New Failures",
                                              "Failures"),
                                          tickets(
                                              Colors.orange,
                                              context,
                                              Icons.track_changes,
                                              "5",
                                              "New Warnings",
                                              "Warnings"),
                                          tickets(
                                              Colors.lightBlue,
                                              context,
                                              Icons.question_answer,
                                              "8",
                                              "New Messages",
                                              "Messages"),
                                          tickets(
                                              Colors.indigo,
                                              context,
                                              Icons.sort,
                                              "2",
                                              "New Insights",
                                              "Insights"),
                                        ]),
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
                            MediaQuery.of(context).size.width < 1300
                                ? 0.6
                                : 0.65,
                        mainAxisSpacing: 10,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            //print('grid item $index');
                            //show the clicked solarinstallation in detailed view
                            dispatchGoToSingleSolarInstallationPageEvent(
                                context, state.solarInstallationList[index]);
                          },
                          child: InstallationDashboardCardWidget(
                            id: state.solarInstallationList[index].id,
                            customerId:
                                state.solarInstallationList[index].customerId,
                            assignedEmployee: state.solarInstallationList[index]
                                .companyEmployeeIds[0],
                            expectedLoad:
                                state.solarInstallationList[index].expectedLoad,
                            inputDCVoltage: state
                                .solarInstallationList[index].inputDCVoltage,
                          ),
                        );
                      }, childCount: state.solarInstallationList.length),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        dispatchGoToCreateSolarInstallationPageEvent(context);
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Colors.lightBlue,
                      tooltip: "Add Solar Installation",
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is CreateSolarInstallationPageState) {
          //dispatchInitializeSolarInstallationFormEvent(context);
          return Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Scaffold(
              backgroundColor: ColorConstants.backgroundGrey,
              appBar: (false)
                  ? null
                  : AppBar(
                      leading: new IconButton(
                        icon: new Icon(Icons.arrow_back),
                        onPressed: () {
                          dispatchInitializeDashboardEvent(context);
                        },
                      ),
                      backgroundColor: ColorConstants.grey,
                    ),
              body: CreateInstallationPage(),
            ),
          );
        }
        if (state is SingleInstallationPageState) {
          //dispatchInitializeSolarInstallationFormEvent(context);
          return Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Scaffold(
              backgroundColor: ColorConstants.backgroundGrey,
              appBar: (false)
                  ? null
                  : AppBar(
                      leading: new IconButton(
                        icon: new Icon(Icons.arrow_back),
                        onPressed: () {
                          dispatchInitializeDashboardEvent(context);
                        },
                      ),
                      backgroundColor: ColorConstants.grey,
                    ),
              body: SingleInstallationPage(state.solarInstallation),
            ),
          );
        }
      }),
    );
  }

  void dispatchInitializeDashboardEvent(context) {
    BlocProvider.of<DashboardBloc>(context)
        .dispatch(InitializeDashboardEvent());
  }

  void dispatchGoToCreateSolarInstallationPageEvent(context) {
    BlocProvider.of<DashboardBloc>(context)
        .dispatch(GoToCreateSolarInstallationPageEvent());
  }

  void dispatchGoToSingleSolarInstallationPageEvent(
      context, solarInstallation) {
    BlocProvider.of<DashboardBloc>(context)
        .dispatch(GoToSingleSolarInstallationPageEvent(solarInstallation));
  }
}
