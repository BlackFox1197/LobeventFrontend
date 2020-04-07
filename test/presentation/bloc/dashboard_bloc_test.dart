import 'dart:convert';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/get_solar_installations_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUseCase {}

class MockGetSolarInstallationUsecase extends Mock
    implements GetSolarInstallationsUseCase {}

void main() {
  DashboardBloc bloc;
  MockGetCurrentUserUsecase mockGetCurrentUserUsecase;
  MockGetSolarInstallationUsecase mockGetSolarInstallationUsecase;

  setUp(() {
    mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();
    mockGetSolarInstallationUsecase = MockGetSolarInstallationUsecase();
    bloc = DashboardBloc(
        getSolarInstallationsUseCase: mockGetSolarInstallationUsecase,
        getCurrentUserUseCase: mockGetCurrentUserUsecase);
  });

  test("initial state should be DashboardUninitializedState", () {
    //assert
    expect(bloc.initialState, equals(DashboardUninitializedState()));
  });

  group("InitializeDashboardEvent", () {
    final UserModel tUser = new UserModel(
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

    test('should get data from the concrete usecase', () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockGetSolarInstallationUsecase(any))
          .thenAnswer((_) async => Right(testSolarInstallationList));
      // act
      bloc.dispatch(InitializeDashboardEvent());
      await untilCalled(mockGetSolarInstallationUsecase(any));
      // assert
      verify(mockGetCurrentUserUsecase(NoParams()));
      verify(mockGetSolarInstallationUsecase(Params(user: tUser)));
    });

    test(
        'should emit [..., DashboardInitializedState] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockGetSolarInstallationUsecase(any))
          .thenAnswer((_) async => Right(testSolarInstallationList));
      // assert later
      final expected = [
        DashboardUninitializedState(),
        DashboardLoadingState(),
        DashboardInitializedState(
            solarInstallationList: testSolarInstallationList),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(InitializeDashboardEvent());
    });

    test(
        'should emit [..., DashboardErrorState] when error occured while fetching data',
        () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockGetSolarInstallationUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure(SERVER_ERROR)));
      // assert later
      final expected = [
        DashboardUninitializedState(),
        DashboardLoadingState(),
        DashboardErrorState(errorMessage: SERVER_ERROR),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(InitializeDashboardEvent());
    });
  }); //end of group

  group("GoToSingleInstallationPageEvent", () {
    final UserModel tUser = new UserModel(
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

    test(
        'should emit [..., SingleInstallationPageState] when GoToSingleInstallationPage was dispatched',
        () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockGetSolarInstallationUsecase(any))
          .thenAnswer((_) async => Right(testSolarInstallationList));
      // assert later
      final expected = [
        DashboardUninitializedState(),
        DashboardLoadingState(),
        DashboardInitializedState(
            solarInstallationList: testSolarInstallationList),
        SingleInstallationPageState(
            solarInstallation: testSolarInstallationList[0]),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(InitializeDashboardEvent());
      bloc.dispatch(
          GoToSingleSolarInstallationPageEvent(testSolarInstallationList[0]));
    });
  }); //end of group

  group("GoToCreateInstallationPageEvent", () {
    final UserModel tUser = new UserModel(
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

    test(
        'should emit [..., CreateSolarInstallationPageState] when GoToCreateInstallationPage was dispatched',
        () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockGetSolarInstallationUsecase(any))
          .thenAnswer((_) async => Right(testSolarInstallationList));
      // assert later
      final expected = [
        DashboardUninitializedState(),
        DashboardLoadingState(),
        DashboardInitializedState(
            solarInstallationList: testSolarInstallationList),
        CreateSolarInstallationPageState(),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(InitializeDashboardEvent());
      bloc.dispatch(GoToCreateSolarInstallationPageEvent());
    });
  }); //end of group
}
