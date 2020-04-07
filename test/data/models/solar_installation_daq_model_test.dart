import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_daq_model.dart';
import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final DAQMeasurement measurement1 = new DAQMeasurement(
    batteryChargeCurrent: "batteryChargeCurrent",
    batteryDischargeCurrent: "batteryDischargeCurrent",
    daqBatteryVoltage: "daqBatteryVoltage",
    inverterOutputVoltage: "inverterOutputVoltage",
    loadCurrentConsumption: "loadCurrentConsumption",
    measuredBatteryVoltage: "measuredBatteryVoltage",
    panelOutputCurrent: "panelOutputCurrent",
    panelOutputVoltage: "panelOutputVoltage",
    solarIrradiance: "solarIrradiance",
    timestamp: "timestamp",
  );
  final DAQMeasurement measurement2 = new DAQMeasurement(
    batteryChargeCurrent: "batteryChargeCurrent",
    batteryDischargeCurrent: "batteryDischargeCurrent",
    daqBatteryVoltage: "daqBatteryVoltage",
    inverterOutputVoltage: "inverterOutputVoltage",
    loadCurrentConsumption: "loadCurrentConsumption",
    measuredBatteryVoltage: "measuredBatteryVoltage",
    panelOutputCurrent: "panelOutputCurrent",
    panelOutputVoltage: "panelOutputVoltage",
    solarIrradiance: "solarIrradiance",
    timestamp: "timestamp",
  );

  final List<DAQMeasurement> daqMeasurement = [];
  daqMeasurement.add(measurement1);
  daqMeasurement.add(measurement2);

  final tSolarInstallationDAQModel = SolarInstallationDaqModel(
    id: "id",
    daqMeasurement: daqMeasurement,
  );
  group('SolarInstallationDAQ Model Check', () {
    test('should be a subclass of SolarInstallationDAQ entity', () async {
      // arrange

      // act

      // assert
      expect(tSolarInstallationDAQModel, isA<SolarInstallationDaq>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation_daq.json'));
      // act
      final result = SolarInstallationDaqModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationDAQModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationDAQModel.toJson();
      // assert
      final expectedMap = {
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
      };
      expect(result, expectedMap);
    });
  });
}
