import 'dart:ui';

import 'package:auditergy_flutter/data/models/solar_installation_battery_pack_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_charge_controller_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_inverter_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_panels_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/injection_container.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/measurement_tabbar_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/solar_installation_data_tabbar_widget.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_listview/installations/single_installation/solar_installation_messages_widget.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleInstallationPage extends StatefulWidget {
  SolarInstallation solarInstallation;
  Map<String, dynamic> generalSolarInstallationData;
  List<Map<String, dynamic>> tableObjects;

  SingleInstallationPage(
    SolarInstallation solarInstallation,
  ) {
    this.solarInstallation = solarInstallation;
    this.generalSolarInstallationData = {
      "Solar Installation ID": solarInstallation.id,
      "Company Admin ID": solarInstallation.solarInstallationProvider,
      "Assigned Employee ID": solarInstallation.companyEmployeeIds[0],
      "Customer ID": solarInstallation.customerId,
      "Date of Installation": solarInstallation.dateOfInstallation,
      "Exptected Load": solarInstallation.expectedLoad,
      "Input DC Voltage": solarInstallation.inputDCVoltage,
      "Number of Interventions": solarInstallation.numberOfInterventions,
      "GPS Latitude": solarInstallation.gpsLocationLat,
      "GPS Longitude": solarInstallation.gpsLocationLong
    };
    this.tableObjects = [];
    // adding generel data
    tableObjects.add(this.generalSolarInstallationData);
    // adding batteryPack
    SolarInstallationBatteryPackModel batteryPack =
        SolarInstallationBatteryPackModel.FromSolarInstallationBatteryPack(
            this.solarInstallation.solarInstallationBatteryPack);
    tableObjects.add(batteryPack.toJson());
    // adding charge controller
    SolarInstallationChargeControllerModel chargeController =
        SolarInstallationChargeControllerModel
            .FromSolarInstallationChargeController(
                this.solarInstallation.solarInstallationChargeController);
    tableObjects.add(chargeController.toJson());
    // adding inverter
    SolarInstallationInverterModel solarInstallationInverterModel =
        SolarInstallationInverterModel.FromSolarInstallationInverter(
            this.solarInstallation.solarInstallationInverter);
    tableObjects.add(solarInstallationInverterModel.toJson());
    // adding panels
    SolarInstallationPanelsModel solarInstallationPanelsModel =
        SolarInstallationPanelsModel.FromSolarInstallationPanels(
            this.solarInstallation.solarInstallationPanels);
    tableObjects.add(solarInstallationPanelsModel.toJson());
  }

  @override
  SingleInstallationPage_State createState() => SingleInstallationPage_State();
}

class SingleInstallationPage_State extends State<SingleInstallationPage> {
  DeleteSolarInstallationBloc _deleteSolarInstallationBloc;

  @override
  initState() {
    _deleteSolarInstallationBloc = sl<DeleteSolarInstallationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeleteSolarInstallationBloc>(
          builder: (_) => _deleteSolarInstallationBloc,
        ),
      ],
      child: BlocBuilder<DeleteSolarInstallationBloc,
          DeleteSolarInstallationState>(builder: (context, state) {
        if (state is DisplayExisingSolarInstallationState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 16.0),
                        child: Container(
                          height: 300,
                          color: Colors.blue,
                          child: Image(
                            image: AssetImage('assets/google_maps_image.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                        child: Center(
                          child: Text(
                            'Solar Installation ID: ${widget.solarInstallation.id}',
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
                              "Status: OK",
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
                                  "Enugu, Nigeria",
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
                          child: MeasurementTabBarWidget(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 600,
                              //give the data objects that should be displayed to the child tabbar
                              child: SolarInstallationDataTabBarWidget(
                                  widget.tableObjects),
                            ),
                            Center(
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    //dispatchInitializeSolarInstallationFormEvent(
                                    //
                                    print("update pressed");
                                  },
                                  child: Text(
                                    'Change Solar Installation Data',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                        child: Container(
                          height: 600,
                          child: SolarInstallationMessagesWidget(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                        child: Center(
                          child: Container(
                            height: 80,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: RaisedButton(
                              color: Colors.red,
                              onPressed: () {
                                //dispatchInitializeSolarInstallationFormEvent(
                                //
                                dispatchSubmitDeleteSolarInstallationEvent(
                                    context);
                                //_deleteDialog(context);
                              },
                              child: Text(
                                'Delete Solar Installation',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'HelveticaNeue',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        }
        if (state is DeleteSolarInstallationLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DeleteSolarInstallationErrorState) {
          return Center(
            child: Text("Error: " + state.errorMessage),
          );
        }
        if (state is DeleteSolarInstallationSuccessState) {
          return Center(
            child: Text("Solar Installation was deleted successfully."),
          );
        }
      }),
    );
  }

  void dispatchDisplayExistingSolarInstallationEvent(context) {
    BlocProvider.of<DeleteSolarInstallationBloc>(context)
        .dispatch(DisplayExistingSolarInstallationEvent());
  }

  void dispatchSubmitDeleteSolarInstallationEvent(context) {
    BlocProvider.of<DeleteSolarInstallationBloc>(context).dispatch(
        SubmitDeleteSolarInstallationEvent(widget.solarInstallation.id));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  _deleteDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you really want to delete the solar installation?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                //dispatchSubmitDeleteSolarInstallationEvent(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
