import 'dart:convert';

import 'package:auditergy_flutter/data/datasources/local_data_source/local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/local_data_source/solar_installation_local_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../domain/core/fixtures/fixture_reader.dart';

class MockHiveDatabase extends Mock implements HiveInterface {}

class MockHiveDatabaseBox extends Mock implements Box {}

void main() {
  LocalDataSourceImpl localDataSource;
  SolarInstallationLocalDataSourceImpl dataSource;
  MockHiveDatabase mockHiveDatabase;

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

  setUp(() {
    mockHiveDatabase = MockHiveDatabase();
    dataSource = SolarInstallationLocalDataSourceImpl(
        boxName: SOLAR_INSTALLATION_BOX, hiveDb: mockHiveDatabase);
  });

  group('getCachedSolarInstallations', () {
    test(
        'should return List of SolarInstallations from HiveDB when there is one in the cache',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any))
          .thenAnswer((_) => fixture('solar_installations_cached.json'));
      // act
      final result = await dataSource.getCachedSolarInstallations();
      // assert
      verify(mockHiveDatabase.openBox(SOLAR_INSTALLATION_BOX));
      expect(result, equals(testSolarInstallationList));
    });

    test('should throw CacheException when there is not a cached value',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      when(box.get(any)).thenThrow(CacheException());
      // act
      final call = await dataSource.getCachedSolarInstallations;
      // assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cache SolarInstallations', () {
    test('should call box.put(..) to cache testSolarInstallationList',
        () async {
      // arrange
      MockHiveDatabaseBox box = new MockHiveDatabaseBox();
      when(mockHiveDatabase.openBox(any)).thenAnswer((_) async => box);
      when(mockHiveDatabase.box(any)).thenAnswer((_) => box);
      // act
      await dataSource.cacheSolarInstallations(testSolarInstallationList);
      // assert
      final expectedJsonString = fixture('solar_installations_cached.json');
      print("fixture");
      print(expectedJsonString);
      verify(mockHiveDatabase.openBox(SOLAR_INSTALLATION_BOX));
      verify(box.put(CACHED_SOLAR_INSTALLATIONS, expectedJsonString));
    });
  });
}
