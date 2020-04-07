// A solar installtions battery
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DAQMeasurement extends Equatable {
  final String batteryChargeCurrent;
  final String batteryDischargeCurrent;
  final String daqBatteryVoltage;
  final String inverterOutputVoltage;
  final String loadCurrentConsumption;
  final String measuredBatteryVoltage;
  final String panelOutputCurrent;
  final String panelOutputVoltage;
  final String solarIrradiance;
  final String timestamp;

  DAQMeasurement({
    @required this.batteryChargeCurrent,
    @required this.batteryDischargeCurrent,
    @required this.daqBatteryVoltage,
    @required this.inverterOutputVoltage,
    @required this.loadCurrentConsumption,
    @required this.measuredBatteryVoltage,
    @required this.panelOutputCurrent,
    @required this.panelOutputVoltage,
    @required this.solarIrradiance,
    @required this.timestamp,
  }) : super([
          batteryChargeCurrent,
          batteryDischargeCurrent,
          daqBatteryVoltage,
          inverterOutputVoltage,
          loadCurrentConsumption,
          measuredBatteryVoltage,
          panelOutputCurrent,
          panelOutputVoltage,
          solarIrradiance,
          timestamp,
        ]);
}
