// A solar installtions battery
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallationBatteryPack extends Equatable {
  final String batteryPackVoltage;
  final String batteryUnitCurrentRating;
  final String batteryUnitVoltageRating;
  final String manufacturer;
  final String numberOfBatteries;
  final String type;

  SolarInstallationBatteryPack({
    @required this.batteryPackVoltage,
    @required this.batteryUnitCurrentRating,
    @required this.batteryUnitVoltageRating,
    @required this.manufacturer,
    @required this.numberOfBatteries,
    @required this.type,
  }) : super([
          batteryPackVoltage,
          batteryUnitCurrentRating,
          batteryUnitVoltageRating,
          manufacturer,
          numberOfBatteries,
          type
        ]);
}
