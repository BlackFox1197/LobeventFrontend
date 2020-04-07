import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_inverter_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_panels_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tSolarInstallationPanelsModel = SolarInstallationPanelsModel(
    dimensionLength: "dimensionLength",
    dimensionThickness: "dimensionThickness",
    dimensionWidth: "dimensionWidth",
    installationVoltageRating: "installationVoltageRating",
    maxCurrent: "maxCurrent",
    maxFuseRating: "maxFuseRating",
    maxPowerRating: "maxPowerRating",
    maxPowerTolerance: "maxPowerTolerance",
    maxSystemVoltage: "maxSystemVoltage",
    maxVoltage: "maxVoltage",
    modelType: "modelType",
    nominalOperatingTemp: "nominalOperatingTemp",
    numberOfPanels: "numberOfPanels",
    openCctVoltage: "openCctVoltage",
    weight: "weight",
  );
  group('SolarInstallationPanels Entity Check', () {
    test('should be a subclass of SolarInstallationPanels entity', () async {
      // arrange

      // act

      // assert
      expect(tSolarInstallationPanelsModel, isA<SolarInstallationPanels>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation_panels.json'));
      // act
      final result = SolarInstallationPanelsModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationPanelsModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationPanelsModel.toJson();
      // assert
      final expectedMap = {
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
      };
      expect(result, expectedMap);
    });
  });
}
