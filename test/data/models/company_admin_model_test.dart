import 'dart:convert';

import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tCompanyAdminModel = CompanyAdminModel(
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
    companyName: "string",
    companyWebsite: "string",
    companyEmployeesIds: ["string"],
  );
  group('CompanyAdmin Entity Check', () {
    test('should be a subclass of CompanyAdmin entity', () async {
      // arrange

      // act

      // assert
      expect(tCompanyAdminModel, isA<CompanyAdmin>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('company_admin.json'));
      // act
      final result = CompanyAdminModel.fromJson(jsonMap);
      // assert
      expect(result, tCompanyAdminModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tCompanyAdminModel.toJson();
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
        "companyName": "string",
        "companyWebsite": "string",
        "companyEmployeesIds": ["string"]
      };
      expect(result, expectedMap);
    });
  });
}
