import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_inverter_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tSolarInstallationInverterModel = SolarInstallationInverterModel(
    inputDCVoltage: "inputDCVoltage",
    kvaRating: "kvaRating",
    manufacturer: "manufacturer",
    outputACVoltage: "outputACVoltage",
    outputFrequency: "outputFrequency",
  );
  group('SolarInstallationInverter Entity Check', () {
    test('should be a subclass of SolarInstallationInverter entity', () async {
      // arrange

      // act

      // assert
      expect(tSolarInstallationInverterModel, isA<SolarInstallationInverter>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation_inverter.json'));
      // act
      final result = SolarInstallationInverterModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationInverterModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationInverterModel.toJson();
      // assert
      final expectedMap = {
        "inputDCVoltage": "inputDCVoltage",
        "kvaRating": "kvaRating",
        "maunfacturer": "manufacturer",
        "outputACVoltage": "outputACVoltage",
        "outputFrequency": "outputFrequency"
      };
      expect(result, expectedMap);
    });
  });
}
