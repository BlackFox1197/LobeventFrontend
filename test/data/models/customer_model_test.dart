import 'dart:convert';

import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

void main() {
  final tCustomerModel = CustomerModel(
    firstname: "string",
    lastname: "string",
    email: "string",
    id: "string",
    country: "string",
    state: "string",
    postalcode: "string",
    street: "string",
    houseNumber: "string",
    phoneNumber: "string",
    solarServiceProviderId: "string",
  );
  group('Customer Entity Check', () {
    test('should be a subclass of Customer entity', () async {
      // arrange

      // act

      // assert
      expect(tCustomerModel, isA<Customer>());
    });
  });

  group('fromJson', () {
    test('should return a valid model when a JSON object is overgiven ',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('customer.json'));
      // act
      final result = CustomerModel.fromJson(jsonMap);
      // assert
      expect(result, tCustomerModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tCustomerModel.toJson();
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
        "solarServiceProviderId": "string"
      };
      expect(result, expectedMap);
    });
  });
}
