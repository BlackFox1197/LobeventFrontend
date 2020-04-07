// A solar installation
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallation extends Equatable {
  final String customerId;
  final String dateOfInstallation;
  final String expectedLoad;
  final String gpsLocationLong;
  final String gpsLocationLat;
  final String inputDCVoltage;
  final String numberOfInterventions;
  final SolarInstallationBatteryPack solarInstallationBatteryPack;
  final SolarInstallationChargeController solarInstallationChargeController;
  final SolarInstallationDaq solarInstallationDaq;

  /// The solar installations unique ID == the same as the daq id
  final String id;
  final SolarInstallationInverter solarInstallationInverter;
  final SolarInstallationPanels solarInstallationPanels;
  final SolarInstallationWeather solarInstallationWeather;
  //TODO: implement the notes as a chronological list
  //final List<SolarInstallationNote> solarInstallationNotes;
  final String solarInstallationProvider;
  final List<String> companyEmployeeIds;

  SolarInstallation({
    @required this.customerId,
    @required this.dateOfInstallation,
    @required this.expectedLoad,
    @required this.gpsLocationLat,
    @required this.gpsLocationLong,
    @required this.inputDCVoltage,
    @required this.numberOfInterventions,
    @required this.solarInstallationBatteryPack,
    @required this.solarInstallationChargeController,
    @required this.solarInstallationDaq,
    @required this.id,
    @required this.solarInstallationInverter,
    @required this.solarInstallationWeather,
    @required this.solarInstallationPanels,
    @required this.companyEmployeeIds,
    @required this.solarInstallationProvider,
  }) : super([
          customerId,
          dateOfInstallation,
          expectedLoad,
          gpsLocationLat,
          gpsLocationLong,
          inputDCVoltage,
          numberOfInterventions,
          solarInstallationBatteryPack,
          solarInstallationChargeController,
          solarInstallationDaq,
          id,
          solarInstallationInverter,
          solarInstallationPanels,
          companyEmployeeIds,
          solarInstallationProvider
        ]);
}
