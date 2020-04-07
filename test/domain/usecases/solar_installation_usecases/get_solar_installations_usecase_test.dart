import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/get_solar_installations_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/fixtures/fixture_reader.dart';

class MockSolarInstallationRepository extends Mock
    implements SolarInstallationRepository {}

void main() {
  GetSolarInstallationsUseCase usecase;
  MockSolarInstallationRepository mockSolarInstallationRepository;

  final User tuser = new User(
    firstname: "John",
    lastname: "Jackson",
    id: "01234",
    email: "test@test.de",
    country: "USA",
    state: "Georgia",
    postalcode: "17645",
    street: "FooBar Avenue",
    houseNumber: "4",
    phoneNumber: "+02356783564",
  );

  final tSolarInstallationModel1 = SolarInstallationModel.fromJson(
      json.decode(fixture('solar_installation.json')));
  final tSolarInstallationModel2 = SolarInstallationModel.fromJson(
      json.decode(fixture('solar_installation.json')));
  final tSolarInstallationModel3 = SolarInstallationModel.fromJson(
      json.decode(fixture('solar_installation.json')));
  final SolarInstallation tSolarInstallation = tSolarInstallationModel1;
  final SolarInstallation tSolarInstallation2 = tSolarInstallationModel2;
  final SolarInstallation tSolarInstallation3 = tSolarInstallationModel3;

  List<SolarInstallationModel> testSolarInstallationList = [];
  testSolarInstallationList.add(tSolarInstallation);
  testSolarInstallationList.add(tSolarInstallation2);
  testSolarInstallationList.add(tSolarInstallation3);

  setUp(() {
    mockSolarInstallationRepository = MockSolarInstallationRepository();
    usecase = GetSolarInstallationsUseCase(mockSolarInstallationRepository);
  });
  test(
    'should get all solar installations of the overgiven user',
    () async {
      //arrange
      Params p = new Params(user: tuser);
      when(mockSolarInstallationRepository.getSolarInstallations(user: p.user))
          .thenAnswer((_) async => Right(testSolarInstallationList));
      //act
      Params p1 = new Params(user: tuser);
      final result = await usecase(p1);
      //assert
      expect(result, Right(testSolarInstallationList));
      verify(
          mockSolarInstallationRepository.getSolarInstallations(user: tuser));
      verifyNoMoreInteractions(mockSolarInstallationRepository);
    },
  );
}

/* //mocking the unimplemented uesecases with mockito

import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/get_solar_installations_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSolarInstallationRepository extends Mock
    implements SolarInstallationRepository {}

void main() {
  GetSolarInstallationsUseCase usecase;
  MockSolarInstallationRepository mockSolarInstallationRepository;

  setUp(() {
    mockSolarInstallationRepository = MockSolarInstallationRepository();
    usecase = GetSolarInstallationsUseCase(mockSolarInstallationRepository);
  });

  final User testUser =
      User(firstName: "test", lastName: "test", email: "test", uid: "1");
  final solarInstallationExample = SolarInstallation(
      location: "location", name: "name", solarInstallationId: "testId");
  final solarInstallationExample2 = SolarInstallation(
      location: "location2", name: "name2", solarInstallationId: "testId2");
  List<SolarInstallation> testSolarInstallationList = [];
  testSolarInstallationList.add(solarInstallationExample);
  testSolarInstallationList.add(solarInstallationExample2);

  test('should get solar installation data from repository', () async {
    // arrange
    //we need to give our mock some abilities to act as we would like to have it
    when(mockSolarInstallationRepository.getSolarInstallations(testUser))
        .thenAnswer((_) async => Right(testSolarInstallationList));
    // act
    final result = await usecase.call(Params(user: testUser));
    // assert
    expect(result, Right(testSolarInstallationList));
    verify(mockSolarInstallationRepository.getSolarInstallations(testUser));
    verifyNoMoreInteractions(mockSolarInstallationRepository);
  });
}
 */
