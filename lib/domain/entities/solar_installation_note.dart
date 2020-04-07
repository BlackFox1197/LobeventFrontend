// A solar installtions battery
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SolarInstallationNote extends Equatable {
  final String id;
  final String timestamp;
  final String note;

  SolarInstallationNote(
      {@required this.id, @required this.note, @required this.timestamp})
      : super([id, note, timestamp]);
}
