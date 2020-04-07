import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:meta/meta.dart';

class SolarInstallationPanelsModel extends SolarInstallationPanels {
  SolarInstallationPanelsModel({
    @required String dimensionLength,
    @required String dimensionThickness,
    @required String dimensionWidth,
    @required String installationVoltageRating,
    @required String maxCurrent,
    @required String maxFuseRating,
    @required String maxPowerRating,
    @required String maxPowerTolerance,
    @required String maxSystemVoltage,
    @required String maxVoltage,
    @required String modelType,
    @required String nominalOperatingTemp,
    @required String numberOfPanels,
    @required String openCctVoltage,
    @required String weight,
  }) : super(
          dimensionLength: dimensionLength,
          dimensionThickness: dimensionThickness,
          dimensionWidth: dimensionWidth,
          installationVoltageRating: installationVoltageRating,
          maxCurrent: maxCurrent,
          maxFuseRating: maxFuseRating,
          maxPowerRating: maxPowerRating,
          maxPowerTolerance: maxPowerTolerance,
          maxSystemVoltage: maxSystemVoltage,
          maxVoltage: maxVoltage,
          modelType: modelType,
          nominalOperatingTemp: nominalOperatingTemp,
          numberOfPanels: numberOfPanels,
          openCctVoltage: openCctVoltage,
          weight: weight,
        );

  factory SolarInstallationPanelsModel.FromSolarInstallationPanels(
      SolarInstallationPanels solarInstallationPanels) {
    return SolarInstallationPanelsModel(
      dimensionLength: solarInstallationPanels.dimensionLength,
      dimensionThickness: solarInstallationPanels.dimensionThickness,
      dimensionWidth: solarInstallationPanels.dimensionWidth,
      installationVoltageRating:
          solarInstallationPanels.installationVoltageRating,
      maxCurrent: solarInstallationPanels.maxCurrent,
      maxFuseRating: solarInstallationPanels.maxFuseRating,
      maxPowerRating: solarInstallationPanels.maxPowerRating,
      maxPowerTolerance: solarInstallationPanels.maxPowerTolerance,
      maxSystemVoltage: solarInstallationPanels.maxSystemVoltage,
      maxVoltage: solarInstallationPanels.maxVoltage,
      modelType: solarInstallationPanels.modelType,
      nominalOperatingTemp: solarInstallationPanels.nominalOperatingTemp,
      numberOfPanels: solarInstallationPanels.numberOfPanels,
      openCctVoltage: solarInstallationPanels.openCctVoltage,
      weight: solarInstallationPanels.weight,
    );
  }

  factory SolarInstallationPanelsModel.fromJson(Map<String, dynamic> json) {
    return SolarInstallationPanelsModel(
      dimensionLength: json['dimensionLength'],
      dimensionThickness: json['dimensionThickness'],
      dimensionWidth: json['dimensionWidth'],
      installationVoltageRating: json['installationVoltageRating'],
      maxCurrent: json['maxCurrent'],
      maxFuseRating: json['maxFuseRating'],
      maxPowerRating: json['maxPowerRating'],
      maxPowerTolerance: json['maxPowerTolerance'],
      maxSystemVoltage: json['maxSystemVoltage'],
      maxVoltage: json['maxVoltage'],
      modelType: json['modelType'],
      nominalOperatingTemp: json['nominalOperatingTemp'],
      numberOfPanels: json['numberOfPanels'],
      openCctVoltage: json['openCctVoltage'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dimensionLength": dimensionLength,
      "dimensionThickness": dimensionThickness,
      "dimensionWidth": dimensionWidth,
      "installationVoltageRating": installationVoltageRating,
      "maxCurrent": maxCurrent,
      "maxFuseRating": maxFuseRating,
      "maxPowerRating": maxPowerRating,
      "maxPowerTolerance": maxPowerTolerance,
      "maxSystemVoltage": maxSystemVoltage,
      "maxVoltage": maxVoltage,
      "modelType": modelType,
      "nominalOperatingTemp": nominalOperatingTemp,
      "numberOfPanels": numberOfPanels,
      "openCctVoltage": openCctVoltage,
      "weight": weight,
    };
  }
}
