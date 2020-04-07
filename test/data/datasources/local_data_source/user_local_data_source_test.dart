import 'dart:convert';

import 'package:auditergy_flutter/data/datasources/local_data_source/local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/local_data_source/solar_installation_local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/local_data_source/user_local_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:hive/hive.dart';

import '../../../domain/core/fixtures/fixture_reader.dart';

class MockHiveDatabase extends Mock implements HiveInterface {}

class MockHiveDatabaseBox extends Mock implements Box {}

void main() {
  //TestWidgetsFlutterBinding.ensureInitialized();
  LocalDataSourceImpl localDataSource;
  UserLocalDataSourceImpl dataSource;
  MockHiveDatabase mockHiveDatabase;

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
  final User tCompanyAdmin = tCompanyAdminModel;

  final tCompanyEmployeeModel = CompanyEmployeeModel(
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
  final User tCompanyEmployee = tCompanyEmployeeModel;

  final tCustomerModel = CustomerModel(
    firstname: "firstname",
    lastname: "lastname",
    email: "email",
    id: "id",
    country: "country",
    state: "state",
    postalcode: "postalcode",
    street: "street",
    houseNumber: "houseNumber",
    phoneNumber: "phoneNumber",
    solarServiceProviderId: "solarServiceProviderId",
  );
  final User tCustomer = tCustomerModel;

  final String accessToken = "accessToken";

  setUp(() async {
    mockHiveDatabase = MockHiveDatabase();
    dataSource =
        UserLocalDataSourceImpl(boxName: USER_BOX, hiveDb: mockHiveDatabase);
  });

  group('cacheCurrentUser', () {
    test('should call box.put(..) to cache CompanyAdmin', () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.cacheCurrentUser(tCompanyAdmin);
      // assert
      final expectedJsonString = json.encode(tCompanyAdminModel.toJson());
      verify(mockHiveDatabase.openBox(USER_BOX));
      verify(box.put(CACHED_USER, expectedJsonString));
    });
    test('should call box.put(..) to cache CompanyEmployee', () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.cacheCurrentUser(tCompanyEmployee);
      // assert
      final expectedJsonString = json.encode(tCompanyEmployeeModel.toJson());
      verify(mockHiveDatabase.openBox(USER_BOX));
      verify(box.put(CACHED_USER, expectedJsonString));
    });
    test('should call box.put(..) to cache Customer', () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.cacheCurrentUser(tCustomer);
      // assert
      final expectedJsonString = json.encode(tCustomerModel.toJson());
      verify(mockHiveDatabase.openBox(USER_BOX));
      verify(box.put(CACHED_USER, expectedJsonString));
    });
  }); //end of group
  group('getCurrentUser', () {
    test('should return User from Hive Database when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any))
          .thenAnswer((_) => json.encode(tCompanyAdminModel.toJson()));
      // act
      final result = await dataSource.getCurrentUser();
      // assert
      verify(mockHiveDatabase.openBox(USER_BOX));
      expect(result, equals(tCompanyAdmin));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any)).thenThrow(CacheException());
      // act
      final call = dataSource.getCurrentUser;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    });
  }); //end of group
  group('deleteCurrentUserfromCache', () {
    test('should delete User from Hive Database when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.deleteCurrentUserFromCache();
      // assert
      verify(mockHiveDatabase.openBox(USER_BOX));
      verify(box.delete(CACHED_USER));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.delete(any)).thenThrow(CacheException());
      // act
      final call = dataSource.deleteCurrentUserFromCache;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    });
  }); //end of group
  group('cacheAccessToken', () {
    test('should call box.put(..) to cache AccessToken', () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.cacheAccessToken(accessToken);
      // assert
      verify(mockHiveDatabase.openBox(TOKEN_BOX_NAME));
      verify(box.put(ACCESS_TOKEN, accessToken));
    });
  }); //end of group
  group('cacheRefreshToken', () {
    /*
    test('should call box.put(..) to cache refreshToken', () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.cacheRefreshToken(refreshToken);
      // assert
      verify(mockHiveDatabase.openBox(TOKEN_BOX_NAME));
      verify(box.put(REFRESH_TOKEN, refreshToken));
    });*/
  }); //end of group
  group('getAccessToken', () {
    test(
        'should return accessToken from Hive Database when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any)).thenAnswer((_) => accessToken);
      // act
      final result = await dataSource.getAccessToken();
      // assert
      verify(mockHiveDatabase.openBox(TOKEN_BOX_NAME));
      expect(result, equals(accessToken));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any)).thenThrow(CacheException());
      // act
      final call = dataSource.getAccessToken;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    });
  }); //end of group

  group('getRefreshToken', () {
    /*
    test(
        'should return refreshToken from Hive Database when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any)).thenAnswer((_) => refreshToken);
      // act
      final result = await dataSource.getRefreshToken();
      // assert
      verify(mockHiveDatabase.openBox(TOKEN_BOX_NAME));
      expect(result, equals(refreshToken));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any)).thenThrow(CacheException());
      // act
      final call = dataSource.getRefreshToken;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    }); */
  }); //end of group
  group('deleteAccessTokenfromCache', () {
    test(
        'should delete accessToken from Hive Database when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.deleteAccessTokenFromCache();
      // assert
      verify(mockHiveDatabase.openBox(TOKEN_BOX_NAME));
      verify(box.delete(ACCESS_TOKEN));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.delete(any)).thenThrow(CacheException());
      // act
      final call = dataSource.deleteAccessTokenFromCache;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    });
  }); //end of group
  group('deleteRefreshTokenfromCache', () {
    test(
        'should delete refreshToken from Hive Database when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.deleteRefreshTokenFromCache();
      // assert
      verify(mockHiveDatabase.openBox(TOKEN_BOX_NAME));
      verify(box.delete(REFRESH_TOKEN));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.delete(any)).thenThrow(CacheException());
      // act
      final call = dataSource.deleteRefreshTokenFromCache;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    });
  }); //end of group
  group('logout', () {
    test(
        'should delete accessToken and cached user from Hive Database when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.logout();
      // assert
      verify(mockHiveDatabase.openBox(USER_BOX));
      verify(box.delete(ACCESS_TOKEN));
      verify(box.delete(CACHED_USER));
    });

    test('should throw CacheException when one of the three is not in cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.delete(any)).thenThrow(CacheException());
      // act
      final call = dataSource.logout;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    });
  }); //end of group
}
