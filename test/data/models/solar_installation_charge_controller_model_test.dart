import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_battery_pack_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_charge_controller_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tSolarInstallationChargeControllerModel =
      SolarInstallationChargeControllerModel(
    boostDuration: "boostDuration",
    boostReturnVoltage: "boostReturnVoltage",
    dischargeCurrent: "dischargeCurrent",
    dischargeReconnect: "dischargeReconnect",
    dischargeStop: "dischargeStop",
    equalizationVoltage: "equalizationVoltage",
    floatChargeVoltage: "floatChargeVoltage",
    highVoltageDisconnect: "highVoltageDisconnect",
    manufacturer: "manufacturer",
    maxSolarInput: "maxSolarInput",
    model: "model",
    operatingTemperature: "operatingTemperature",
    type: "type",
  );
  group('SolarInstallationChargeController Entity Check', () {
    test('should be a subclass of SolarInstallationChargeController entity',
        () async {
      // arrange

      // act

      // assert
      expect(tSolarInstallationChargeControllerModel,
          isA<SolarInstallationChargeController>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation_charge_controller.json'));
      // act
      final result = SolarInstallationChargeControllerModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationChargeControllerModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationChargeControllerModel.toJson();
      // assert
      final expectedMap = {
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
        "type": "type",
      };
      expect(result, expectedMap);
    });
  });
}
