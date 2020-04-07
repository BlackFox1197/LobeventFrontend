import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:meta/meta.dart';

class SolarInstallationChargeControllerModel
    extends SolarInstallationChargeController {
  SolarInstallationChargeControllerModel({
    @required String boostDuration,
    @required String boostReturnVoltage,
    @required String dischargeCurrent,
    @required String dischargeReconnect,
    @required String dischargeStop,
    @required String equalizationVoltage,
    @required String floatChargeVoltage,
    @required String highVoltageDisconnect,
    @required String manufacturer,
    @required String maxSolarInput,
    @required String model,
    @required String operatingTemperature,
    @required String type,
  }) : super(
          boostDuration: boostDuration,
          boostReturnVoltage: boostReturnVoltage,
          dischargeCurrent: dischargeCurrent,
          dischargeReconnect: dischargeReconnect,
          dischargeStop: dischargeStop,
          equalizationVoltage: equalizationVoltage,
          floatChargeVoltage: floatChargeVoltage,
          highVoltageDisconnect: highVoltageDisconnect,
          manufacturer: manufacturer,
          maxSolarInput: maxSolarInput,
          model: model,
          operatingTemperature: operatingTemperature,
          type: type,
        );

  factory SolarInstallationChargeControllerModel.FromSolarInstallationChargeController(
      SolarInstallationChargeController solarInstallationChargeController) {
    return SolarInstallationChargeControllerModel(
      boostDuration: solarInstallationChargeController.boostDuration,
      boostReturnVoltage: solarInstallationChargeController.boostReturnVoltage,
      dischargeCurrent: solarInstallationChargeController.dischargeCurrent,
      dischargeReconnect: solarInstallationChargeController.dischargeReconnect,
      dischargeStop: solarInstallationChargeController.dischargeStop,
      equalizationVoltage:
          solarInstallationChargeController.equalizationVoltage,
      floatChargeVoltage: solarInstallationChargeController.floatChargeVoltage,
      highVoltageDisconnect:
          solarInstallationChargeController.highVoltageDisconnect,
      manufacturer: solarInstallationChargeController.manufacturer,
      maxSolarInput: solarInstallationChargeController.maxSolarInput,
      model: solarInstallationChargeController.model,
      operatingTemperature:
          solarInstallationChargeController.operatingTemperature,
      type: solarInstallationChargeController.type,
    );
  }

  factory SolarInstallationChargeControllerModel.fromJson(
      Map<String, dynamic> json) {
    return SolarInstallationChargeControllerModel(
      boostDuration: json['boostDuration'],
      boostReturnVoltage: json['boostReturnVoltage'],
      dischargeCurrent: json['dischargeCurrent'],
      dischargeReconnect: json['dischargeReconnect'],
      dischargeStop: json['dischargeStop'],
      equalizationVoltage: json['equalizationVoltage'],
      floatChargeVoltage: json['floatChargeVoltage'],
      highVoltageDisconnect: json['highVoltageDisconnect'],
      manufacturer: json['manufacturer'],
      maxSolarInput: json['maxSolarInput'],
      model: json['model'],
      operatingTemperature: json['operatingTemperature'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "boostDuration": boostDuration,
      "boostReturnVoltage": boostReturnVoltage,
      "dischargeCurrent": dischargeCurrent,
      "dischargeReconnect": dischargeReconnect,
      "dischargeStop": dischargeStop,
      "equalizationVoltage": equalizationVoltage,
      "floatChargeVoltage": floatChargeVoltage,
      "highVoltageDisconnect": highVoltageDisconnect,
      "manufacturer": manufacturer,
      "maxSolarInput": maxSolarInput,
      "model": model,
      "operatingTemperature": operatingTemperature,
      "type": type,
    };
  }
}
