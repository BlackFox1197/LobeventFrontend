import 'dart:convert';

import 'package:auditergy_flutter/data/datasources/remote_data_source/solar_installation_remote_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../domain/core/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  SolarInstallationRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SolarInstallationRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getSolarInstallations', () {
    final tSolarInstallationModel1 = SolarInstallationModel.fromJson(
        json.decode(fixture('solar_installation.json')));
    final tSolarInstallationModel2 = SolarInstallationModel.fromJson(
        json.decode(fixture('solar_installation.json')));
    final tSolarInstallationModel3 = SolarInstallationModel.fromJson(
        json.decode(fixture('solar_installation.json')));

    List<SolarInstallationModel> testSolarInstallationList = [];
    testSolarInstallationList.add(tSolarInstallationModel1);
    testSolarInstallationList.add(tSolarInstallationModel2);
    testSolarInstallationList.add(tSolarInstallationModel3);

    final CompanyAdminModel tCompanyAdmin = new CompanyAdminModel(
        firstname: "John",
        lastname: "Jackson",
        id: "01234",
        email: "example@ex.com",
        country: "USA",
        state: "Georgia",
        postalcode: "17645",
        street: "FooBar Avenue",
        houseNumber: "4",
        phoneNumber: "+02356783564",
        companyName: "companyXYC",
        companyWebsite: "www.company.com",
        companyEmployeesIds: ["234234", "234234", "234234"]);
    final CustomerModel tCustomer = new CustomerModel(
        firstname: "firstname",
        lastname: "lastname",
        id: "id",
        email: "email",
        country: "country",
        state: "state",
        postalcode: "postalcode",
        street: "street",
        houseNumber: "houseNumber",
        phoneNumber: "phoneNumber",
        solarServiceProviderId: "solarServiceProviderId");
    final CompanyEmployeeModel tCompanyEmployee = new CompanyEmployeeModel(
      firstname: "firstname",
      lastname: "lastname",
      id: "id",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalcode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyId: "companyId",
    );
    final String tAccessToken = "token";

    test(
        '''Company Admin Case: should perform a GET request on a URL with a list of
         solar installations beeing the endpoint and with application/json header''',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('solar_installations.json'), 200));
      final String companyAdminGetSolarInstallationsRoute =
          GET_COMPANY_ADMIN_SOLAR_INSTALLATIONS_URI + "/" + tCompanyAdmin.id;
      // act
      dataSource.getSolarInstallations(tCompanyAdmin, tAccessToken);
      // assert
      verify(mockHttpClient.get(
        companyAdminGetSolarInstallationsRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH,
        },
      ));
    });

    test(
        '''Company Employee Case: should perform a GET request on a URL with a list of
         solar installations beeing the endpoint and with application/json header''',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('solar_installations.json'), 200));
      final String companyEmployeeGetSolarInstallationsRoute =
          GET_COMPANY_EMPLOYEE_SOLAR_INSTALLATIONS_URI +
              "/" +
              tCompanyEmployee.id;
      // act
      dataSource.getSolarInstallations(tCompanyEmployee, tAccessToken);
      // assert
      verify(mockHttpClient.get(
        companyEmployeeGetSolarInstallationsRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH,
        },
      ));
    });

    test('''Customer Case: should perform a GET request on a URL with a list of
         solar installations beeing the endpoint and with application/json header''',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('solar_installations.json'), 200));
      final String customerGetSolarInstallationsRoute =
          GET_CUSTOMER_SOLAR_INSTALLATIONS_URI + "/" + tCustomer.id;
      // act
      dataSource.getSolarInstallations(tCustomer, tAccessToken);
      // assert
      verify(mockHttpClient.get(
        customerGetSolarInstallationsRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH,
        },
      ));
    });

    test(
        'should return List of SolarInstallationModels when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('solar_installations.json'), 200));
      // act
      final result =
          await dataSource.getSolarInstallations(tCompanyAdmin, tAccessToken);
      // assert
      expect(result, equals(testSolarInstallationList));
    });

    test(
        'should throw ServerException when the response code is 404 or other error code',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response('ERROR: Something went wrong', 404));
      // act
      final call = dataSource.getSolarInstallations;
      // assert
      expect(() => call(tCompanyAdmin, tAccessToken),
          throwsA(TypeMatcher<ServerException>()));
    });
  }); //end of top group

  group('createSolarInstallation', () {
    final tSolarInstallation = SolarInstallationModel.fromJson(
        json.decode(fixture('solar_installation.json')));

    test(
        '''should perform a POST request on a URL with a boolean beeing the endpoint and with application/json header''',
        () async {
      // arrange
      String accessToken = "accessToken";
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('create_solar_installation_server_response_success.json'),
              200));
      // act
      dataSource.createSolarInstallation(tSolarInstallation, accessToken);
      // assert
      verify(mockHttpClient.post(CREATE_SOLAR_INSTALLATION_URI,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': API_BASIC_AUTH,
          },
          body: anyNamed('body'),
          encoding: null));
    });
    test(
        'should return true when the response code is 200 and the status is success',
        () async {
      // arrange
      String accessToken = "accessToken";
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('create_solar_installation_server_response_success.json'),
              200));
      // act
      final result = await dataSource.createSolarInstallation(
          tSolarInstallation, accessToken);
      // assert
      expect(result, equals(true));
    });
    test(
        'should throw ServerException when the response code is 200, but there is a failure in the response',
        () async {
      // arrange
      String accessToken = "accessToken";
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('create_solar_installation_server_response_failure.json'),
              200));
      // act
      final call = dataSource.createSolarInstallation;
      // assert
      expect(() async => await call(tSolarInstallation, accessToken),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      String accessToken = "accessToken";
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('create_solar_installation_server_response_success.json'),
              404));
      // act
      final call = dataSource.createSolarInstallation;
      // assert
      expect(() async => await call(tSolarInstallation, accessToken),
          throwsA(TypeMatcher<ServerException>()));
    });
    test(
        'should throw ServerException when the response code is 200, but there is no failure and no success',
        () async {
      // arrange
      String accessToken = "accessToken";
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture(
                  'create_solar_installation_server_response_notvalid.json'),
              200));
      // act
      final call = dataSource.createSolarInstallation;
      // assert
      expect(() async => await call(tSolarInstallation, accessToken),
          throwsA(TypeMatcher<ServerException>()));
    });
  }); // end of top group

  group('deleteSolarInstallation', () {
    String tSolarInstallationId = "solarInstallationId";
    test(
        '''should perform a POST request on a URL with a boolean beeing the endpoint and with application/json header''',
        () async {
      // arrange
      String accessToken = "accessToken";
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_solar_installation_server_response_success.json'),
          200));
      final String uniqueSolarInstallationDeleteRoute =
          DELETE_SOLAR_INSTALLATION_URI + "/" + tSolarInstallationId;
      // act
      dataSource.deleteSolarInstallation(tSolarInstallationId, accessToken);
      // assert
      verify(mockHttpClient.delete(
        uniqueSolarInstallationDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH,
        },
      ));
    });
    test(
        'should return true when the response code is 200 and the status is success',
        () async {
      // arrange
      String accessToken = "accessToken";
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_solar_installation_server_response_success.json'),
          200));
      // act
      final result = await dataSource.deleteSolarInstallation(
          tSolarInstallationId, accessToken);
      // assert
      expect(result, equals(true));
    });
    test(
        'should throw ServerException when the response code is 200, but there is a failure in the response',
        () async {
      // arrange
      String accessToken = "accessToken";

      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_solar_installation_server_response_failure.json'),
          200));
      // act
      final call = dataSource.deleteSolarInstallation;
      // assert
      expect(() async => await call(tSolarInstallationId, accessToken),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      String accessToken = "accessToken";

      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_solar_installation_server_response_success.json'),
          404));
      // act
      final call = dataSource.deleteSolarInstallation;
      // assert
      expect(() async => await call(tSolarInstallationId, accessToken),
          throwsA(TypeMatcher<ServerException>()));
    });
    test(
        'should throw ServerException when the response code is 200, but there is no failure and no success',
        () async {
      // arrange
      String accessToken = "accessToken";

      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_solar_installation_server_response_notvalid.json'),
          200));
      // act
      final call = dataSource.deleteSolarInstallation;
      // assert
      expect(() async => await call(tSolarInstallationId, accessToken),
          throwsA(TypeMatcher<ServerException>()));
    });
  }); // end of top group
}
