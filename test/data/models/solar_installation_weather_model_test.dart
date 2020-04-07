import 'dart:convert';
import 'package:auditergy_flutter/data/models/solar_installation_weather_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tSolarInstallationWeatherModel = SolarInstallationWeatherModel(
    id: "id",
  );
  group('SolarInstallationWeatherModel Entity Check', () {
    test('should be a subclass of SolarInstallationWeather entity', () async {
      // arrange

      // act

      // assert
      expect(tSolarInstallationWeatherModel, isA<SolarInstallationWeather>());
    });
  });
  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation_weather.json'));
      // act
      final result = SolarInstallationWeatherModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationWeatherModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationWeatherModel.toJson();
      // assert
      final expectedMap = {"id": "id"};
      expect(result, expectedMap);
    });
  });
}
