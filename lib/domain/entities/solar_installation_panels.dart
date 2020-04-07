// A solar installtions battery
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallationPanels extends Equatable {
  final String dimensionLength;
  final String dimensionThickness;
  final String dimensionWidth;
  final String installationVoltageRating;
  final String maxCurrent;
  final String maxFuseRating;
  final String maxPowerRating;
  final String maxPowerTolerance;
  final String maxSystemVoltage;
  final String maxVoltage;
  final String modelType;
  final String nominalOperatingTemp;
  final String numberOfPanels;
  final String openCctVoltage;
  final String weight;

  SolarInstallationPanels({
    @required this.dimensionLength,
    @required this.dimensionThickness,
    @required this.dimensionWidth,
    @required this.installationVoltageRating,
    @required this.maxCurrent,
    @required this.maxFuseRating,
    @required this.maxPowerRating,
    @required this.maxPowerTolerance,
    @required this.maxSystemVoltage,
    @required this.maxVoltage,
    @required this.modelType,
    @required this.nominalOperatingTemp,
    @required this.numberOfPanels,
    @required this.openCctVoltage,
    @required this.weight,
  }) : super([
          dimensionLength,
          dimensionThickness,
          dimensionWidth,
          installationVoltageRating,
          maxCurrent,
          maxFuseRating,
          maxPowerRating,
          maxPowerTolerance,
          maxVoltage,
          modelType,
          nominalOperatingTemp,
          numberOfPanels,
          openCctVoltage,
          weight
        ]);
}
