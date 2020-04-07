import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:meta/meta.dart';

class SolarInstallationBatteryPackModel extends SolarInstallationBatteryPack {
  SolarInstallationBatteryPackModel({
    @required String batteryPackVoltage,
    @required String batteryUnitCurrentRating,
    @required String batteryUnitVoltageRating,
    @required String manufacturer,
    @required String numberOfBatteries,
    @required String type,
  }) : super(
          batteryPackVoltage: batteryPackVoltage,
          batteryUnitCurrentRating: batteryUnitCurrentRating,
          batteryUnitVoltageRating: batteryUnitVoltageRating,
          manufacturer: manufacturer,
          numberOfBatteries: numberOfBatteries,
          type: type,
        );

  factory SolarInstallationBatteryPackModel.FromSolarInstallationBatteryPack(
      SolarInstallationBatteryPack solarInstallationBatteryPack) {
    return SolarInstallationBatteryPackModel(
        batteryPackVoltage: solarInstallationBatteryPack.batteryPackVoltage,
        batteryUnitCurrentRating:
            solarInstallationBatteryPack.batteryUnitCurrentRating,
        batteryUnitVoltageRating:
            solarInstallationBatteryPack.batteryUnitVoltageRating,
        manufacturer: solarInstallationBatteryPack.manufacturer,
        numberOfBatteries: solarInstallationBatteryPack.numberOfBatteries,
        type: solarInstallationBatteryPack.type);
  }

  factory SolarInstallationBatteryPackModel.fromJson(
      Map<String, dynamic> json) {
    return SolarInstallationBatteryPackModel(
      batteryPackVoltage: json['batteryPackVoltage'],
      batteryUnitCurrentRating: json['batteryUnitcurrentRating'],
      batteryUnitVoltageRating: json['batteryUnitVoltageRating'],
      manufacturer: json['manufacturer'],
      numberOfBatteries: json['numberOfBatteries'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "batteryPackVoltage": batteryPackVoltage,
      "batteryUnitcurrentRating": batteryUnitCurrentRating,
      "batteryUnitVoltageRating": batteryUnitVoltageRating,
      "manufacturer": manufacturer,
      "numberOfBatteries": numberOfBatteries,
      "type": type,
    };
  }
}
