// A solar installtions battery
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallationChargeController extends Equatable {
  final String boostDuration;
  final String boostReturnVoltage;
  final String dischargeCurrent;
  final String dischargeReconnect;
  final String dischargeStop;
  final String equalizationVoltage;
  final String floatChargeVoltage;
  final String highVoltageDisconnect;
  final String manufacturer;
  final String maxSolarInput;
  final String model;
  final String operatingTemperature;
  final String type;

  SolarInstallationChargeController({
    @required this.boostDuration,
    @required this.boostReturnVoltage,
    @required this.dischargeCurrent,
    @required this.dischargeReconnect,
    @required this.dischargeStop,
    @required this.equalizationVoltage,
    @required this.floatChargeVoltage,
    @required this.highVoltageDisconnect,
    @required this.manufacturer,
    @required this.maxSolarInput,
    @required this.model,
    @required this.operatingTemperature,
    @required this.type,
  }) : super([
          boostDuration,
          boostReturnVoltage,
          dischargeCurrent,
          dischargeReconnect,
          dischargeStop,
          equalizationVoltage,
          floatChargeVoltage,
          highVoltageDisconnect,
          manufacturer,
          maxSolarInput,
          model,
          operatingTemperature,
          type,
        ]);
}
