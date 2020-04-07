import 'dart:convert';

import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final UserModel tUserModel = new UserModel(
    firstname: "string",
    lastname: "string",
    id: "string",
    email: "string",
    country: "string",
    state: "string",
    postalcode: "string",
    street: "string",
    houseNumber: "string",
    phoneNumber: "string",
  );

  group('User Entity Check', () {
    test('should be a subclass of User entity', () async {
      expect(tUserModel, isA<User>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      expect(result, tUserModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tUserModel.toJson();
      // assert
      final expectedMap = {
        "firstname": "string",
        "lastname": "string",
        "id": "string",
        "email": "string",
        "country": "string",
        "state": "string",
        "postalcode": "string",
        "street": "string",
        "houseNumber": "string",
        "phoneNumber": "string",
      };
      expect(result, expectedMap);
    });
  });
}
