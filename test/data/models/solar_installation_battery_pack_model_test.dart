import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_battery_pack_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tSolarInstallationBatteryPackModel = SolarInstallationBatteryPackModel(
    batteryPackVoltage: "batteryPackVoltage",
    //TODO: API spell problem ...
    batteryUnitCurrentRating: "batteryUnitcurrentRating",
    batteryUnitVoltageRating: "batteryUnitVoltageRating",
    manufacturer: "manufacturer",
    numberOfBatteries: "numberOfBatteries",
    type: "type",
  );
  group('SolarInstallationBatteryPack Entity Check', () {
    test('should be a subclass of SolarInstallationBatteryPack entity',
        () async {
      // arrange

      // act

      // assert
      expect(tSolarInstallationBatteryPackModel,
          isA<SolarInstallationBatteryPack>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation_battery_pack.json'));
      print(jsonMap);
      // act
      final result = SolarInstallationBatteryPackModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationBatteryPackModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationBatteryPackModel.toJson();
      // assert
      final expectedMap = {
        "batteryPackVoltage": "batteryPackVoltage",
        "batteryUnitcurrentRating": "batteryUnitcurrentRating",
        "batteryUnitVoltageRating": "batteryUnitVoltageRating",
        "manufacturer": "manufacturer",
        "numberOfBatteries": "numberOfBatteries",
        "type": "type",
      };
      expect(result, expectedMap);
    });
  });
}
