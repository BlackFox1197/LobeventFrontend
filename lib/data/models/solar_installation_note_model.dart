import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:meta/meta.dart';

class SolarInstallationNoteModel extends SolarInstallationNote {
  SolarInstallationNoteModel(
      {@required String id, @required String note, @required String timestamp})
      : super(
          id: id,
          note: note,
          timestamp: timestamp,
        );

  factory SolarInstallationNoteModel.FromSolarInstallationNote(
      SolarInstallationNote solarInstallationNote) {
    return SolarInstallationNoteModel(
      id: solarInstallationNote.id,
      note: solarInstallationNote.note,
      timestamp: solarInstallationNote.timestamp,
    );
  }

  factory SolarInstallationNoteModel.fromJson(Map<String, dynamic> json) {
    return SolarInstallationNoteModel(
      id: json['id'],
      note: json['note'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "note": note,
      "timestamp": timestamp,
    };
  }
}
