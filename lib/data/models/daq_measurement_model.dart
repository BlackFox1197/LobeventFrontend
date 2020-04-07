import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:meta/meta.dart';

class DAQMeasurementModel extends DAQMeasurement {
  DAQMeasurementModel({
    @required String batteryChargeCurrent,
    @required String batteryDischargeCurrent,
    @required String daqBatteryVoltage,
    @required String inverterOutputVoltage,
    @required String loadCurrentConsumption,
    @required String measuredBatteryVoltage,
    @required String panelOutputCurrent,
    @required String panelOutputVoltage,
    @required String solarIrradiance,
    @required String timestamp,
  }) : super(
          batteryChargeCurrent: batteryChargeCurrent,
          batteryDischargeCurrent: batteryDischargeCurrent,
          daqBatteryVoltage: daqBatteryVoltage,
          inverterOutputVoltage: inverterOutputVoltage,
          loadCurrentConsumption: loadCurrentConsumption,
          measuredBatteryVoltage: measuredBatteryVoltage,
          panelOutputCurrent: panelOutputCurrent,
          panelOutputVoltage: panelOutputVoltage,
          solarIrradiance: solarIrradiance,
          timestamp: timestamp,
        );

  factory DAQMeasurementModel.FromDaqMeasurement(
      DAQMeasurement daqMeasurement) {
    return DAQMeasurementModel(
      batteryChargeCurrent: daqMeasurement.batteryChargeCurrent,
      batteryDischargeCurrent: daqMeasurement.batteryDischargeCurrent,
      daqBatteryVoltage: daqMeasurement.daqBatteryVoltage,
      inverterOutputVoltage: daqMeasurement.inverterOutputVoltage,
      loadCurrentConsumption: daqMeasurement.loadCurrentConsumption,
      measuredBatteryVoltage: daqMeasurement.measuredBatteryVoltage,
      panelOutputCurrent: daqMeasurement.panelOutputCurrent,
      panelOutputVoltage: daqMeasurement.panelOutputVoltage,
      solarIrradiance: daqMeasurement.solarIrradiance,
      timestamp: daqMeasurement.timestamp,
    );
  }

  factory DAQMeasurementModel.fromJson(Map<String, dynamic> json) {
    return DAQMeasurementModel(
      batteryChargeCurrent: json['batteryChargeCurrent'],
      batteryDischargeCurrent: json['batteryDischargeCurrent'],
      daqBatteryVoltage: json['daqBatteryVoltage'],
      inverterOutputVoltage: json['inverterOutputVoltage'],
      loadCurrentConsumption: json['loadCurrentConsumption'],
      measuredBatteryVoltage: json['measuredBatteryVoltage'],
      panelOutputCurrent: json['panelOutputCurrent'],
      panelOutputVoltage: json['panelOutputVoltage'],
      solarIrradiance: json['solarIrradiance'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "batteryChargeCurrent": batteryChargeCurrent,
      "batteryDischargeCurrent": batteryDischargeCurrent,
      "daqBatteryVoltage": daqBatteryVoltage,
      "inverterOutputVoltage": inverterOutputVoltage,
      "loadCurrentConsumption": loadCurrentConsumption,
      "measuredBatteryVoltage": measuredBatteryVoltage,
      "panelOutputCurrent": panelOutputCurrent,
      "panelOutputVoltage": panelOutputVoltage,
      "solarIrradiance": solarIrradiance,
      "timestamp": timestamp,
    };
  }
}
