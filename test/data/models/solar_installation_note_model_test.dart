import 'dart:convert';
import 'package:auditergy_flutter/data/models/solar_installation_note_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final SolarInstallationNoteModel tSolarInstallationNoteModel =
      new SolarInstallationNoteModel(
    id: "id",
    note: "note",
    timestamp: "timestamp",
  );

  group('SolarInstallationNote Entity Check', () {
    test('should be a subclass of SolarInstallationNote entity', () async {
      expect(tSolarInstallationNoteModel, isA<SolarInstallationNote>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('solar_installation_note.json'));
      // act
      final result = SolarInstallationNoteModel.fromJson(jsonMap);
      // assert
      expect(result, tSolarInstallationNoteModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tSolarInstallationNoteModel.toJson();
      // assert
      final expectedMap = {
        "id": "id",
        "note": "note",
        "timestamp": "timestamp"
      };
      expect(result, expectedMap);
    });
  });
}
