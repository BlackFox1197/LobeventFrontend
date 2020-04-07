import 'dart:convert';

import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tCompanyEmployeeModel = CompanyEmployeeModel(
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
    companyId: "string",
  );
  group('CompanyEmployee Entity Check', () {
    test('should be a subclass of CompanyEmployee entity', () async {
      // arrange

      // act

      // assert
      expect(tCompanyEmployeeModel, isA<CompanyEmployee>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('company_employee.json'));
      // act
      final result = CompanyEmployeeModel.fromJson(jsonMap);
      // assert
      expect(result, tCompanyEmployeeModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tCompanyEmployeeModel.toJson();
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
        "companyId": "string"
      };
      expect(result, expectedMap);
    });
  });
}
