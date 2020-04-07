import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:meta/meta.dart';

class SolarInstallationWeatherModel extends SolarInstallationWeather {
  SolarInstallationWeatherModel({
    @required String id,
  }) : super(
          id: id,
        );

  factory SolarInstallationWeatherModel.FromSolarInstallationWeather(
      SolarInstallationWeather solarInstallationWeather) {
    return SolarInstallationWeatherModel(
      id: solarInstallationWeather.id,
    );
  }

  factory SolarInstallationWeatherModel.fromJson(Map<String, dynamic> json) {
    return SolarInstallationWeatherModel(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}
