// A solar installtions battery
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallationWeather extends Equatable {
  /// The user's first name.
  final String id;

  SolarInstallationWeather({
    @required this.id,
  }) : super([id]);
}
