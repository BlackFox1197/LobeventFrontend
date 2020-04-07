import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tSolarInstallationModel = SolarInstallationModel.fromJson(
      json.decode(fixture('solar_installation.json')));
  group('SolarInstallation Model Check', () {
    test('should be a subclass of SolarInstallation entity', () async {
      // arrange

      // act

      // assert
      expect(tSolarInstallationModel, isA<SolarInstallation>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation.json'));
      print(jsonMap);
      // act
      final result = SolarInstallationModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationModel.toJson();
      // assert
      final expectedMap = {
        "customerId": "customerId",
        "dateOfInstallation": "dateOfInstallation",
        "expectedLoad": "expectedLoad",
        "gpsLocationLong": "gpsLocationLong",
        "gpsLocationLat": "gpsLocationLat",
        "inputDCVoltage": "inputDCVoltage",
        "numberOfInterventions": "numberOfInterventions",
        "solarInstallationBatteryPack": {
          "batteryPackVoltage": "batteryPackVoltage",
          "batteryUnitcurrentRating": "batteryUnitcurrentRating",
          "batteryUnitVoltageRating": "batteryUnitVoltageRating",
          "manufacturer": "manufacturer",
          "numberOfBatteries": "numberOfBatteries",
          "type": "type"
        },
        "solarInstallationChargeController": {
          "boostDuration": "boostDuration",
          "boostReturnVoltage": "boostReturnVoltage",
          "dischargeCurrent": "dischargeCurrent",
          "dischargeReconnect": "dischargeReconnect",
          "dischargeStop": "dischargeStop",
          "equalizationVoltage": "equalizationVoltage",
          "floatChargeVoltage": "floatChargeVoltage",
          "highVoltageDisconnect": "highVoltageDisconnect",
          "manufacturer": "manufacturer",
          "maxSolarInput": "maxSolarInput",
          "model": "model",
          "operatingTemperature": "operatingTemperature",
          "type": "type"
        },
        "solarInstallationDaq": {
          "id": "id",
          "daqMeasurement": [
            {
              "batteryChargeCurrent": "batteryChargeCurrent",
              "batteryDischargeCurrent": "batteryDischargeCurrent",
              "daqBatteryVoltage": "daqBatteryVoltage",
              "inverterOutputVoltage": "inverterOutputVoltage",
              "loadCurrentConsumption": "loadCurrentConsumption",
              "measuredBatteryVoltage": "measuredBatteryVoltage",
              "panelOutputCurrent": "panelOutputCurrent",
              "panelOutputVoltage": "panelOutputVoltage",
              "solarIrradiance": "solarIrradiance",
              "timestamp": "timestamp"
            },
            {
              "batteryChargeCurrent": "batteryChargeCurrent",
              "batteryDischargeCurrent": "batteryDischargeCurrent",
              "daqBatteryVoltage": "daqBatteryVoltage",
              "inverterOutputVoltage": "inverterOutputVoltage",
              "loadCurrentConsumption": "loadCurrentConsumption",
              "measuredBatteryVoltage": "measuredBatteryVoltage",
              "panelOutputCurrent": "panelOutputCurrent",
              "panelOutputVoltage": "panelOutputVoltage",
              "solarIrradiance": "solarIrradiance",
              "timestamp": "timestamp"
            }
          ]
        },
        "id": "id",
        "solarInstallationInverter": {
          "inputDCVoltage": "inputDCVoltage",
          "kvaRating": "kvaRating",
          "maunfacturer": "maunfacturer",
          "outputACVoltage": "outputACVoltage",
          "outputFrequency": "outputFrequency"
        },
        "solarInstallationPanels": {
          "dimensionLength": "dimensionLength",
          "dimensionThickness": "dimensionThickness",
          "dimensionWidth": "dimensionWidth",
          "installationVoltageRating": "installationVoltageRating",
          "maxCurrent": "maxCurrent",
          "maxFuseRating": "maxFuseRating",
          "maxPowerRating": "maxPowerRating",
          "maxPowerTolerance": "maxPowerTolerance",
          "maxSystemVoltage": "maxSystemVoltage",
          "maxVoltage": "maxVoltage",
          "modelType": "modelType",
          "nominalOperatingTemp": "nominalOperatingTemp",
          "numberOfPanels": "numberOfPanels",
          "openCctVoltage": "openCctVoltage",
          "weight": "weight"
        },
        "solarInstallationWeather": {"id": "id"},
        "solarInstalltionProvider": "solarInstallationProvider",
        "companyEmployeeIds": ["string"]
      };
      expect(result, expectedMap);
    });
  });
}
