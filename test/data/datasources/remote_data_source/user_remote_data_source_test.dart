import 'dart:convert';
import 'package:auditergy_flutter/data/datasources/remote_data_source/user_remote_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../domain/core/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  UserRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('deleteAccount', () {
    final UserModel tUserModel = new UserModel(
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
    );
    final CompanyAdminModel tCompanyAdminM = new CompanyAdminModel(
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
        companyId: "companyId");
    final User tUser = tUserModel;
    final String tpassword = "password";
    test(
        '''should perform a DELETE request on a URL with a user beeing the endpoint and with application/json header''',
        () async {
      // arrange
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_account_server_responce_success.json'), 200));
      final String uniqueUserDeleteRoute =
          COMPANY_ADMIN_DELETE_URI + "/" + tCompanyAdminM.id;
      // act
      dataSource.deleteAccount(tCompanyAdminM);
      // assert
      verify(mockHttpClient.delete(
        uniqueUserDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      ));
    });
    test(
        'should return true(case CompanyAdmin) when the response code is 200 and the status is success',
        () async {
      // arrange
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_account_server_responce_success.json'), 200));
      final String uniqueUserDeleteRoute =
          COMPANY_ADMIN_DELETE_URI + "/" + tCompanyAdminM.id;
      // act
      final result = await dataSource.deleteAccount(tCompanyAdminM);
      // assert
      verify(mockHttpClient.delete(
        uniqueUserDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      ));
      expect(result, equals(true));
    });
    test(
        'should return User(case Customer) when the response code is 200 and the status is success',
        () async {
      // arrange
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_account_server_responce_success.json'), 200));
      final String uniqueUserDeleteRoute =
          CUSTOMER_DELETE_API + "/" + tCustomer.id;
      // act
      final result = await dataSource.deleteAccount(tCustomer);
      // assert
      verify(mockHttpClient.delete(
        uniqueUserDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      ));
      expect(result, equals(true));
    });
    test(
        'should return true (case CompanyEmployee) when the response code is 200 and success:true',
        () async {
      // arrange
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_account_server_responce_success.json'), 200));
      final String uniqueUserDeleteRoute =
          COMPANY_EMPLOYEE_DELETE_URI + "/" + tCompanyEmployee.id;
      // act
      final result = await dataSource.deleteAccount(tCompanyEmployee);
      // assert
      verify(mockHttpClient.delete(
        uniqueUserDeleteRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      ));
      expect(result, equals(true));
    });
    test(
        'should throw ServerException when the response code is 200, but there is a failure in the response',
        () async {
      // arrange
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_account_server_responce_failure.json'), 200));
      // act
      final call = dataSource.deleteAccount;
      // assert
      expect(() async => await call(tCompanyAdminM),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_account_server_responce_failure.json'), 404));
      // act
      final call = dataSource.deleteAccount;
      // assert
      expect(() async => await call(tCompanyEmployee),
          throwsA(TypeMatcher<ServerException>()));
    });
    test(
        'should throw ServerException when the response code is 200, but there is no failure and no success',
        () async {
      // arrange
      when(mockHttpClient.delete(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          fixture('delete_account_server_responce_notvalid.json'), 200));
      // act
      final call = dataSource.deleteAccount;
      // assert
      expect(() async => await call(tCustomer),
          throwsA(TypeMatcher<ServerException>()));
    });
  });
  group('register', () {
    final UserModel tUserModel = new UserModel(
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
    );
    final CompanyAdminModel tCompanyAdminM = new CompanyAdminModel(
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
        companyId: "companyId");
    final User tUser = tUserModel;
    final String tpassword = "password";
    test(
        '''should perform a POST request on a URL with a user beeing the endpoint and with application/json header''',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_registration_server_responce_success.json'), 200));
      // act
      dataSource.register(tCompanyAdminM, tpassword);
      // assert
      verify(mockHttpClient.post(COMPANY_ADMIN_REGISTER_URI,
          headers:
              //(IV) see problem below. Cant simulate same hash.
              anyNamed('headers'),
          body:
              //(IV)the problem why we cant check it with the test password is that password is hashed
              //and the hash function gets a randomized parameter in the login function so we cant simulate it
              anyNamed('body'),
          encoding: null));
    });
    test(
        'should return true(case CompanyAdmin) when the response code is 200 and the status is success',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_registration_server_responce_success.json'), 200));
      // act
      final result = await dataSource.register(tCompanyAdminM, tpassword);
      // assert
      expect(result, equals(true));
    });
    test(
        'should return User(case Customer) when the response code is 200 and the status is success',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_registration_server_responce_success.json'), 200));
      // act
      final result = await dataSource.register(tCustomer, tpassword);
      // assert
      expect(result, equals(true));
    });
    test(
        'should return User(case CompanyEmployee) when the response code is 200 and the status is success',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_registration_server_responce_success.json'), 200));
      // act
      final result = await dataSource.register(tCompanyEmployee, tpassword);
      // assert
      expect(result, equals(true));
    });
    test(
        'should throw ServerException when the response code is 200, but there is a failure in the response',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_registration_server_responce_failure.json'), 404));
      // act
      final call = dataSource.register;
      // assert
      expect(() async => await call(tCompanyAdminM, tpassword),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_registration_server_responce_success.json'), 404));
      // act
      final call = dataSource.register;
      // assert
      expect(() async => await call(tCompanyEmployee, tpassword),
          throwsA(TypeMatcher<ServerException>()));
    });
    test(
        'should throw ServerException when the response code is 200, but there is no failure and no success',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_registration_server_responce_notvalid.json'), 404));
      // act
      final call = dataSource.register;
      // assert
      expect(() async => await call(tCustomer, tpassword),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('login', () {
    final String temail = "example@ex.com";
    final String tpassword = "foobar";
    final UserModel tUserModel = new UserModel(
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
    );
    final CompanyAdminModel tCompanyAdminM = new CompanyAdminModel(
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
        companyId: "companyId");
    final User tUser = tUserModel;
    test(
        '''should perform a POST request on a URL with a user beeing the endpoint and with application/json header''',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_login_server_responce_success_companyadmin.json'),
              200));
      // act
      dataSource.login(temail, tpassword);
      // assert
      verify(mockHttpClient.post(LOGIN_URI,
          headers: {
            'Content-Type': 'application/json',
            'authorization': API_BASIC_AUTH
          },
          body:
              //(IV)the problem why we cant check it with the test password is that password is hashed
              //and the hash function gets a randomized parameter in the login function so we cant simulate it
              anyNamed('body'),
          encoding: null));
    });
    test(
        'should return User(case CompanyAdmin) when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_login_server_responce_success_companyadmin.json'),
              200));
      // act
      final result = await dataSource.login(temail, tpassword);
      // assert
      expect(result[0], equals(tCompanyAdminM));
    });
    test(
        'should return User(case Customer) when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_login_server_responce_success_customer.json'),
              200));
      // act
      final result = await dataSource.login(temail, tpassword);
      // assert
      expect(result[0], equals(tCustomer));
    });
    test(
        'should return User(case CompanyEmployee) when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture(
                  'user_login_server_responce_success_companyemployee.json'),
              200));
      // act
      final result = await dataSource.login(temail, tpassword);
      // assert
      expect(result[0], equals(tCompanyEmployee));
    });
    test(
        'should throw ServerException when the response code is 200, but there is a failure in the response',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_login_server_responce_failure_c1.json'), 200));
      // act
      final call = dataSource.login;
      // assert
      expect(() async => await call(temail, tpassword),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture(
                  'user_login_server_responce_success_companyemployee.json'),
              404));
      // act
      final call = dataSource.login;
      // assert
      expect(() async => await call(temail, tpassword),
          throwsA(TypeMatcher<ServerException>()));
    });
    test(
        'should throw ServerException when the response code is 200, but there is no failure and no success',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_login_server_responce_failure_c1.json'), 200));
      // act
      final call = dataSource.login;
      // assert
      expect(() async => await call(temail, tpassword),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('forgotPassword', () {
    final String tEmail = "example@ex.com";
    test('''should perform a POST request on a URL with bool as endpoint''',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_forgot_password_server_response_success.json'),
              200));
      // act
      dataSource.forgotPassword(tEmail);
      // assert
      verify(mockHttpClient.post(FORGOT_PASSWORD_URI,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'email': '$tEmail'})));
    });

    test('should return true when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_forgot_password_server_response_success.json'),
              200));
      // act
      final result = await dataSource.forgotPassword(tEmail);
      // assert
      expect(result, equals(true));
    });

    test(
        'should throw ServerException when the response code is 404 or other error code',
        () async {
      // arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response('ERROR: Something went wrong', 404));
      // act
      final call = dataSource.forgotPassword;
      // assert
      expect(() async => await call(tEmail),
          throwsA(const TypeMatcher<ServerException>()));
    });
  }); //end of top group

  group('updateUserData', () {
    final tCompanyAdminModel = CompanyAdminModel(
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
      companyName: "companyName",
      companyWebsite: "companyWebsite",
      companyEmployeesIds: ["1", "2", "3"],
    );
    final CompanyAdmin tCompanyAdmin = tCompanyAdminModel;
    String tAccessToken = "token";
    test(
        '''should perform a POST request on a URL with user object as endpoint''',
        () async {
      // arrange
      when(mockHttpClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_update_user_data_response_success.json'), 200));
      Map<String, dynamic> request = tCompanyAdminModel.toJson();
      request.putIfAbsent('userType', () => "ADMIN");
      final String uniqueUserUpdateRoute =
          UPDATE_COMPANY_ADMIN_URI + "/" + tCompanyAdminModel.id;
      // act
      await dataSource.updateUserData([tCompanyAdmin, tAccessToken]);
      // assertt
      verify(mockHttpClient.put(uniqueUserUpdateRoute,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': API_BASIC_AUTH,
          },
          body: json.encode(request)));
    });

    test('should return user object when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              fixture('user_update_user_data_response_success.json'), 200));
      // act
      final result =
          await dataSource.updateUserData([tCompanyAdmin, tAccessToken]);
      // assert
      expect(result, equals(tCompanyAdmin));
    });

    test(
        'should throw ServerException when the response code is 404 or other error code',
        () async {
      // arrange
      when(mockHttpClient.put(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response('ERROR: Something went wrong', 404));
      // act
      final call = dataSource.updateUserData;
      // assert
      expect(() async => await call([tCompanyAdmin, tAccessToken]),
          throwsA(const TypeMatcher<ServerException>()));
    });
  }); //end of top group
}
