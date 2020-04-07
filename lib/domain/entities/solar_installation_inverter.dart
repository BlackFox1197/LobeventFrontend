// A solar installtions battery
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallationInverter extends Equatable {
  final String inputDCVoltage;
  final String kvaRating;
  final String manufacturer;
  final String outputACVoltage;
  final String outputFrequency;

  SolarInstallationInverter({
    @required this.inputDCVoltage,
    @required this.kvaRating,
    @required this.manufacturer,
    @required this.outputACVoltage,
    @required this.outputFrequency,
  }) : super([
          inputDCVoltage,
          kvaRating,
          manufacturer,
          outputACVoltage,
          outputFrequency
        ]);
}
