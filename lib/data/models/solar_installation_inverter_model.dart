import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:meta/meta.dart';

class SolarInstallationInverterModel extends SolarInstallationInverter {
  SolarInstallationInverterModel({
    @required String inputDCVoltage,
    @required String kvaRating,
    @required String manufacturer,
    @required String outputACVoltage,
    @required String outputFrequency,
  }) : super(
          inputDCVoltage: inputDCVoltage,
          kvaRating: kvaRating,
          manufacturer: manufacturer,
          outputACVoltage: outputACVoltage,
          outputFrequency: outputFrequency,
        );

  factory SolarInstallationInverterModel.FromSolarInstallationInverter(
      SolarInstallationInverter solarInstallationInverter) {
    return SolarInstallationInverterModel(
      inputDCVoltage: solarInstallationInverter.inputDCVoltage,
      kvaRating: solarInstallationInverter.kvaRating,
      manufacturer: solarInstallationInverter.manufacturer,
      outputACVoltage: solarInstallationInverter.outputACVoltage,
      outputFrequency: solarInstallationInverter.outputFrequency,
    );
  }

  factory SolarInstallationInverterModel.fromJson(Map<String, dynamic> json) {
    return SolarInstallationInverterModel(
      inputDCVoltage: json['inputDCVoltage'],
      kvaRating: json['kvaRating'],
      //TODO: api spell problem...
      manufacturer: json['maunfacturer'],
      outputACVoltage: json['outputACVoltage'],
      outputFrequency: json['outputFrequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "inputDCVoltage": inputDCVoltage,
      "kvaRating": kvaRating,
      //TODO: api spell problem ...
      "maunfacturer": manufacturer,
      "outputACVoltage": outputACVoltage,
      "outputFrequency": outputFrequency,
    };
  }
}
