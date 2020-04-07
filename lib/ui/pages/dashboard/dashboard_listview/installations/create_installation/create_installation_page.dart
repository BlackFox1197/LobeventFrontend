import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:auditergy_flutter/injection_container.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateInstallationPage extends StatefulWidget {
  final List<String> tabs = [
    "General Data",
    "Battery Pack",
    "Charge Controller",
    "Inverter",
    "Panels"
  ];
  @override
  CreateInstallationPage_State createState() => CreateInstallationPage_State();
}

class CreateInstallationPage_State extends State<CreateInstallationPage> {
  //final _formKey = GlobalKey<FormState>();
  var companyAdminTextFieldController = TextEditingController();
  CreateSolarInstallationBloc _createSolarInstallationBloc;
  //General Installation Variables
  String solarInstallationId = "";
  String companyAdminId = "";
  String customerId = "";
  String expectedLoad = "";
  //Battery Pack Variables
  String batteryPackVoltage = "";
  String batteryUnitCurrentRating = "";
  String batteryUnitVoltageRating = "";
  String battery_manufacturer = "";
  String numberOfBatteries = "";
  String battery_type = "";
  //Charge Controller Variables
  String boostDuration = "";
  String boostReturnVoltage = "";
  String dischargeCurrent = "";
  String dischargeReconnect = "";
  String dischargeStop = "";
  String equalizationVoltage = "";
  String floatChargeVoltage = "";
  //Inverter Variables
  String inputDCVoltage = "";
  String kvaRating = "";
  String inverter_manufacturer = "";
  String outputACVoltage = "";
  String outputFrequency = "";
  //Panel Variables
  String dimensionLength = "";
  String dimensionThickness = "";
  String dimensionWidth = "";
  String installationVoltageRating = "";
  String maxCurrent = "";
  String maxFuseRating = "";
  String maxPowerRating = "";

  @override
  initState() {
    _createSolarInstallationBloc = sl<CreateSolarInstallationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateSolarInstallationBloc>(
      builder: (_) => _createSolarInstallationBloc,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: BlocBuilder<CreateSolarInstallationBloc,
              CreateSolarInstallationState>(
            builder: (context, state) {
              if (state is CreateSolarInstallationUninitializedState) {
                dispatchInitializeSolarInstallationFormEvent(context);
                return Center(
                  child: Text("Initializing ..."),
                );
              } else if (state is CreateSolarInstallationLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CreateSolarInstallationErrorState) {
                return Center(
                  child: Text("Error: " + state.errorMessage),
                );
              } else if (state is CreateSolarInstallationInitializedState) {
                companyAdminTextFieldController.text = state.currentUser.id;
                companyAdminId = state.currentUser.id;
                return Column(
                  children: <Widget>[
                    Container(
                      height: 500,
                      child: DefaultTabController(
                        length: widget.tabs.length,
                        child: Scaffold(
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            title: Text("Create Solar Installation"),
                            backgroundColor: ColorConstants.grey,
                            bottom: TabBar(
                              isScrollable: true,
                              tabs: <Widget>[
                                for (final tab in widget.tabs) Tab(text: tab),
                              ],
                            ),
                          ),
                          body: TabBarView(
                            children: <Widget>[
                              //Generel Installation Data
                              Container(
                                color: Colors.white,
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Key')),
                                    DataColumn(label: Text('Value')),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Solar Installation ID')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              solarInstallationId = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Company Admin ID')),
                                        DataCell(
                                          TextField(
                                            controller:
                                                companyAdminTextFieldController,
                                            onChanged: (text) {
                                              companyAdminId = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Customer ID')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              customerId = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Expected Load')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              expectedLoad = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //Battery Pack Data
                              Container(
                                color: Colors.white,
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Key')),
                                    DataColumn(label: Text('Value')),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Battery Pack Voltage')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              batteryPackVoltage = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                            'Battery Unit Voltage Rating')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              batteryUnitVoltageRating = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                            'Battery Unit Current Rating')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              batteryUnitCurrentRating = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Manufacturer')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              battery_manufacturer = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Number of Batteries')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              numberOfBatteries = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Type')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              battery_type = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Charge Controller Data
                              Container(
                                color: Colors.white,
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Key')),
                                    DataColumn(label: Text('Value')),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Boost Duration')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              boostDuration = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Boost Return Voltage')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              boostReturnVoltage = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Discharge Current')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              dischargeCurrent = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Discharge Reconnect')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              dischargeReconnect = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Discharge Stop')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              dischargeStop = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Equalization Voltage')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              equalizationVoltage = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Floar Charge Voltage')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              floatChargeVoltage = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Inverter Data
                              Container(
                                color: Colors.white,
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Key')),
                                    DataColumn(label: Text('Value')),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Input DC Voltage')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              inputDCVoltage = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('KVA Rating')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              kvaRating = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Manufacturer')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              inverter_manufacturer = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Outpt AC Voltage')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              outputACVoltage = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Outpt Frequency')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              outputFrequency = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Panels Data
                              Container(
                                color: Colors.white,
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Key')),
                                    DataColumn(label: Text('Value')),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Dimension Length')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              dimensionLength = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Dimension Thickness')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              dimensionThickness = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Dimension Width')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              dimensionWidth = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                            'Installation Voltage Rating')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              installationVoltageRating = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Max Current')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              maxCurrent = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Max Fuse Rating')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              maxFuseRating = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(Text('Max Power Rating')),
                                        DataCell(
                                          TextField(
                                            onChanged: (text) {
                                              maxPowerRating = text;
                                            },
                                          ),
                                          showEditIcon: true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            dispatchSubmitSolarInstallationFormEvent(context);
                          },
                          child: Text(
                            'Create Installation',
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
                );
              } else if (state is CreateSolarInstallationSuccessState) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text("Installation was created successfully."),
                      ),
                      Center(
                        child: Container(
                          height: 80,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              dispatchInitializeSolarInstallationFormEvent(
                                  context);
                            },
                            child: Text(
                              'Create Another Solar Installation',
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
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  void dispatchSubmitSolarInstallationFormEvent(context) {
    final SolarInstallationBatteryPack solarInstallationBatteryPack =
        new SolarInstallationBatteryPack(
      batteryPackVoltage: batteryPackVoltage,
      batteryUnitCurrentRating: batteryUnitCurrentRating,
      batteryUnitVoltageRating: batteryUnitVoltageRating,
      manufacturer: battery_manufacturer,
      numberOfBatteries: numberOfBatteries,
      type: battery_type,
    );

    final solarInstallationChargeController = SolarInstallationChargeController(
      boostDuration: boostDuration,
      boostReturnVoltage: boostReturnVoltage,
      dischargeCurrent: dischargeCurrent,
      dischargeReconnect: dischargeReconnect,
      dischargeStop: dischargeStop,
      equalizationVoltage: equalizationVoltage,
      floatChargeVoltage: floatChargeVoltage,
      highVoltageDisconnect: "",
      manufacturer: "",
      maxSolarInput: "",
      model: "",
      operatingTemperature: "",
      type: "",
    );

    final List<DAQMeasurement> daqMeasurement = [];

    final solarInstallationDaq = SolarInstallationDaq(
      id: "id",
      daqMeasurement: daqMeasurement,
    );

    final solarInstallationInverterModel = SolarInstallationInverter(
      inputDCVoltage: inputDCVoltage,
      kvaRating: kvaRating,
      manufacturer: inverter_manufacturer,
      outputACVoltage: outputACVoltage,
      outputFrequency: outputFrequency,
    );

    final solarInstallationPanels = SolarInstallationPanels(
      dimensionLength: dimensionLength,
      dimensionThickness: dimensionThickness,
      dimensionWidth: dimensionWidth,
      installationVoltageRating: installationVoltageRating,
      maxCurrent: maxCurrent,
      maxFuseRating: maxFuseRating,
      maxPowerRating: maxPowerRating,
      maxPowerTolerance: "",
      maxSystemVoltage: "",
      maxVoltage: "",
      modelType: "",
      nominalOperatingTemp: "",
      numberOfPanels: "",
      openCctVoltage: "",
      weight: "",
    );

    final solarInstallationWeather = SolarInstallationWeather(
      id: "id",
    );

    final solarInstallation = SolarInstallation(
      customerId: customerId,
      dateOfInstallation: "",
      expectedLoad: expectedLoad,
      gpsLocationLong: "",
      gpsLocationLat: "",
      inputDCVoltage: "",
      numberOfInterventions: "",
      solarInstallationBatteryPack: solarInstallationBatteryPack,
      solarInstallationChargeController: solarInstallationChargeController,
      solarInstallationDaq: solarInstallationDaq,
      id: solarInstallationId,
      solarInstallationInverter: solarInstallationInverterModel,
      solarInstallationPanels: solarInstallationPanels,
      solarInstallationWeather: solarInstallationWeather,
      //solarInstallationNotes: solarInstallationNotes,
      solarInstallationProvider: companyAdminId,
      companyEmployeeIds: [""],
    );
    BlocProvider.of<CreateSolarInstallationBloc>(context)
        .dispatch(SubmitSolarInstallationFormEvent(solarInstallation));
  }

  void dispatchInitializeSolarInstallationFormEvent(context) {
    BlocProvider.of<CreateSolarInstallationBloc>(context)
        .dispatch(InitializeSolarInstallationFormEvent());
  }
}
