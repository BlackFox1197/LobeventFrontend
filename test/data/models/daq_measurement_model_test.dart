import 'dart:convert';

import 'package:auditergy_flutter/data/models/daq_measurement_model.dart';
import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tDAQMeasurementModel = DAQMeasurementModel(
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
  group('DAQMeasurement Entity Check', () {
    test('should be a subclass of DAQMeasurement entity', () async {
      // arrange

      // act

      // assert
      expect(tDAQMeasurementModel, isA<DAQMeasurement>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('daq_measurement.json'));
      // act
      final result = DAQMeasurementModel.fromJson(jsonMap);
      // assert
      expect(result, tDAQMeasurementModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tDAQMeasurementModel.toJson();
      // assert
      final expectedMap = {
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
      };
      expect(result, expectedMap);
    });
  });
}
