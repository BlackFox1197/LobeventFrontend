import 'dart:convert';

import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/create_solar_installation_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUseCase {}

class MockCreateSolarInstallationUsecase extends Mock
    implements CreateSolarInstallationUseCase {}

void main() {
  CreateSolarInstallationBloc bloc;
  MockGetCurrentUserUsecase mockGetCurrentUserUsecase;
  MockCreateSolarInstallationUsecase mockCreateSolarInstallationUsecase;

  setUp(() {
    mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();
    mockCreateSolarInstallationUsecase = MockCreateSolarInstallationUsecase();
    bloc = CreateSolarInstallationBloc(
        createSolarInstallationUseCase: mockCreateSolarInstallationUsecase,
        getCurrentUserUseCase: mockGetCurrentUserUsecase);
  });

  test("initial state should be CreateSolarInstallationUninitializedState", () {
    //assert
    expect(
        bloc.initialState, equals(CreateSolarInstallationUninitializedState()));
  });

  group("SubmitSolarInstallationFormEvent", () {
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

    final tSolarInstallation = SolarInstallationModel.fromJson(
        json.decode(fixture('solar_installation.json')));

    test('should get data from the concrete usecase', () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockCreateSolarInstallationUsecase(any))
          .thenAnswer((_) async => Right(true));
      // act
      bloc.dispatch(InitializeSolarInstallationFormEvent());
      bloc.dispatch(SubmitSolarInstallationFormEvent(tSolarInstallation));
      await untilCalled(mockCreateSolarInstallationUsecase(any));
      // assert
      verify(mockGetCurrentUserUsecase(NoParams()));
      verify(mockCreateSolarInstallationUsecase(
          Params(solarInstallation: tSolarInstallation)));
    });

    test(
        'should emit [..., CreateSolarInstallationSuccess] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockCreateSolarInstallationUsecase(any))
          .thenAnswer((_) async => Right(true));
      // assert later
      final expected = [
        CreateSolarInstallationUninitializedState(),
        CreateSolarInstallationLoadingState(),
        CreateSolarInstallationInitializedState(currentUser: tUser),
        CreateSolarInstallationLoadingState(),
        CreateSolarInstallationSuccessState(),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(InitializeSolarInstallationFormEvent());
      bloc.dispatch(SubmitSolarInstallationFormEvent(tSolarInstallation));
    });

    test(
        'should emit [..., CreateSolarInstallationErrorState] when error occured while fetching data',
        () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockCreateSolarInstallationUsecase(any))
          .thenAnswer((_) async => Left(ServerFailure(SERVER_ERROR)));
      // assert later
      final expected = [
        CreateSolarInstallationUninitializedState(),
        CreateSolarInstallationLoadingState(),
        CreateSolarInstallationInitializedState(currentUser: tUser),
        CreateSolarInstallationLoadingState(),
        CreateSolarInstallationErrorState(errorMessage: SERVER_ERROR),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(InitializeSolarInstallationFormEvent());
      bloc.dispatch(SubmitSolarInstallationFormEvent(tSolarInstallation));
    });

    test(
        'should emit [..., CreateSolarInstallationErrorState] with appropriate failure message when fetching data failed',
        () async {
      // arrange
      when(mockGetCurrentUserUsecase(any))
          .thenAnswer((_) async => Right(tUser));
      when(mockCreateSolarInstallationUsecase(any))
          .thenAnswer((_) async => Left(CacheFailure(CACHE_ERROR)));
      // assert later
      final expected = [
        CreateSolarInstallationUninitializedState(),
        CreateSolarInstallationLoadingState(),
        CreateSolarInstallationInitializedState(currentUser: tUser),
        CreateSolarInstallationLoadingState(),
        CreateSolarInstallationErrorState(errorMessage: CACHE_ERROR),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(InitializeSolarInstallationFormEvent());
      bloc.dispatch(SubmitSolarInstallationFormEvent(tSolarInstallation));
    });
  }); //end of group
}
