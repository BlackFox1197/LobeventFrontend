// A solar installtions battery
import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallationDaq extends Equatable {
  final String id;
  final List<DAQMeasurement> daqMeasurement;

  SolarInstallationDaq({@required this.id, @required this.daqMeasurement})
      : super([id, daqMeasurement]);
}
