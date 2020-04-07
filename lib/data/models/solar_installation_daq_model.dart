import 'package:auditergy_flutter/data/models/daq_measurement_model.dart';
import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:meta/meta.dart';

class SolarInstallationDaqModel extends SolarInstallationDaq {
  SolarInstallationDaqModel(
      {@required String id, @required List<DAQMeasurement> daqMeasurement})
      : super(
          id: id,
          daqMeasurement: daqMeasurement,
        );

  factory SolarInstallationDaqModel.FromSolarInstallationDaq(
      SolarInstallationDaq solarInstallationDaq) {
    return SolarInstallationDaqModel(
      id: solarInstallationDaq.id,
      daqMeasurement: solarInstallationDaq.daqMeasurement,
    );
  }

  factory SolarInstallationDaqModel.fromJson(Map<String, dynamic> json) {
    var daqMeasurementJson = json['daqMeasurement'] as List;
    List<DAQMeasurement> daqMeasurement = daqMeasurementJson != null
        ? daqMeasurementJson.map((i) {
            DAQMeasurementModel daqMeasurementModel =
                DAQMeasurementModel.fromJson(i);
            return new DAQMeasurement(
              batteryChargeCurrent: daqMeasurementModel.batteryChargeCurrent,
              batteryDischargeCurrent:
                  daqMeasurementModel.batteryDischargeCurrent,
              daqBatteryVoltage: daqMeasurementModel.daqBatteryVoltage,
              inverterOutputVoltage: daqMeasurementModel.inverterOutputVoltage,
              loadCurrentConsumption:
                  daqMeasurementModel.loadCurrentConsumption,
              measuredBatteryVoltage:
                  daqMeasurementModel.measuredBatteryVoltage,
              panelOutputCurrent: daqMeasurementModel.panelOutputCurrent,
              panelOutputVoltage: daqMeasurementModel.panelOutputVoltage,
              solarIrradiance: daqMeasurementModel.solarIrradiance,
              timestamp: daqMeasurementModel.timestamp,
            );
          }).toList()
        : null;

    return SolarInstallationDaqModel(
      id: json['id'],
      daqMeasurement: daqMeasurement,
    );
  }

  Map<String, dynamic> toJson() {
    List<DAQMeasurementModel> daqMeasurementModels = daqMeasurement != null
        ? daqMeasurement
            .map((i) => new DAQMeasurementModel(
                  batteryChargeCurrent: i.batteryChargeCurrent,
                  batteryDischargeCurrent: i.batteryDischargeCurrent,
                  daqBatteryVoltage: i.daqBatteryVoltage,
                  inverterOutputVoltage: i.inverterOutputVoltage,
                  loadCurrentConsumption: i.loadCurrentConsumption,
                  measuredBatteryVoltage: i.measuredBatteryVoltage,
                  panelOutputCurrent: i.panelOutputCurrent,
                  panelOutputVoltage: i.panelOutputVoltage,
                  solarIrradiance: i.solarIrradiance,
                  timestamp: i.timestamp,
                ))
            .toList()
        : null;
    List<Map<String, dynamic>> daqMeasurementsJson =
        daqMeasurementModels != null
            ? daqMeasurementModels.map((i) => i.toJson()).toList()
            : null;
    return {
      "id": id,
      "daqMeasurement": daqMeasurementsJson,
    };
  }
}
