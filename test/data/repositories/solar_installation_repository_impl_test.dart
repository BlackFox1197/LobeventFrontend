import 'dart:convert';

import 'package:auditergy_flutter/data/datasources/local_data_source/solar_installation_local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/remote_data_source/solar_installation_remote_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/data/repositories/solar_installation_repository_impl.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/network/network_info.dart';
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
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/core/fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock
    implements SolarInstallationRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements SolarInstallationLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  SolarInstallationRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SolarInstallationRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getSolarInstallations', () {
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

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getSolarInstallations(user: tCompanyAdmin);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getSolarInstallations(
                tCompanyAdmin, tAccessToken))
            .thenAnswer((_) async => testSolarInstallationList);
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => tAccessToken);
        // act
        final result =
            await repository.getSolarInstallations(user: tCompanyAdmin);
        // assert
        verify(mockRemoteDataSource.getSolarInstallations(
            tCompanyAdmin, tAccessToken));
        expect(result, equals(Right(testSolarInstallationList)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getSolarInstallations(
                tCompanyAdmin, tAccessToken))
            .thenAnswer((_) async => testSolarInstallationList);
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => tAccessToken);
        // act
        await repository.getSolarInstallations(user: tCompanyAdmin);
        // assert
        verify(mockRemoteDataSource.getSolarInstallations(
            tCompanyAdmin, tAccessToken));
        verify(mockLocalDataSource
            .cacheSolarInstallations(testSolarInstallationList));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getSolarInstallations(
                tCompanyAdmin, tAccessToken))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => tAccessToken);
        // act
        final result =
            await repository.getSolarInstallations(user: tCompanyAdmin);
        // assert
        verify(mockRemoteDataSource.getSolarInstallations(
            tCompanyAdmin, tAccessToken));
        expect(result, equals(Left(ServerFailure(SERVER_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedSolarInstallations())
            .thenAnswer((_) async => testSolarInstallationList);
        // act
        final result =
            await repository.getSolarInstallations(user: tCompanyAdmin);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedSolarInstallations());
        expect(result, equals(Right(testSolarInstallationList)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedSolarInstallations())
            .thenThrow(CacheException());
        // act
        final result =
            await repository.getSolarInstallations(user: tCompanyAdmin);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedSolarInstallations());
        expect(result, equals(Left(CacheFailure(CACHE_ERROR))));
      });
    });
  }); //end of top group

  group('createSolarInstallation', () {
    final SolarInstallationBatteryPack solarInstallationBatteryPack =
        new SolarInstallationBatteryPack(
      batteryPackVoltage: "batteryPackVoltage",
      batteryUnitCurrentRating: "batteryUnitcurrentRating",
      batteryUnitVoltageRating: "batteryUnitVoltageRating",
      manufacturer: "manufacturer",
      numberOfBatteries: "numberOfBatteries",
      type: "type",
    );

    final solarInstallationChargeController = SolarInstallationChargeController(
      boostDuration: "boostDuration",
      boostReturnVoltage: "boostReturnVoltage",
      dischargeCurrent: "dischargeCurrent",
      dischargeReconnect: "dischargeReconnect",
      dischargeStop: "dischargeStop",
      equalizationVoltage: "equalizationVoltage",
      floatChargeVoltage: "floatChargeVoltage",
      highVoltageDisconnect: "highVoltageDisconnect",
      manufacturer: "manufacturer",
      maxSolarInput: "maxSolarInput",
      model: "model",
      operatingTemperature: "operatingTemperature",
      type: "type",
    );

    final DAQMeasurement measurement1 = new DAQMeasurement(
      batteryChargeCurrent: "batteryChargeCurrent",
      batteryDischargeCurrent: "batteryDischargeCurrent",
      daqBatteryVoltage: "daqBatteryVoltage",
      inverterOutputVoltage: "inverterOutputVoltage",
      loadCurrentConsumption: "loadCurrentConsumption",
      measuredBatteryVoltage: "measuredBatteryVoltage",
      panelOutputCurrent: "panelOutputCurrent",
      panelOutputVoltage: "panelOutputVoltage",
      solarIrradiance: "solarIrradiance",
      timestamp: "timestamp",
    );
    final DAQMeasurement measurement2 = new DAQMeasurement(
      batteryChargeCurrent: "batteryChargeCurrent",
      batteryDischargeCurrent: "batteryDischargeCurrent",
      daqBatteryVoltage: "daqBatteryVoltage",
      inverterOutputVoltage: "inverterOutputVoltage",
      loadCurrentConsumption: "loadCurrentConsumption",
      measuredBatteryVoltage: "measuredBatteryVoltage",
      panelOutputCurrent: "panelOutputCurrent",
      panelOutputVoltage: "panelOutputVoltage",
      solarIrradiance: "solarIrradiance",
      timestamp: "timestamp",
    );

    final List<DAQMeasurement> daqMeasurement = [];
    daqMeasurement.add(measurement1);
    daqMeasurement.add(measurement2);

    final solarInstallationDaq = SolarInstallationDaq(
      id: "id",
      daqMeasurement: daqMeasurement,
    );

    final solarInstallationInverterModel = SolarInstallationInverter(
      inputDCVoltage: "inputDCVoltage",
      kvaRating: "kvaRating",
      manufacturer: "maunfacturer",
      outputACVoltage: "outputACVoltage",
      outputFrequency: "outputFrequency",
    );

    final solarInstallationPanels = SolarInstallationPanels(
      dimensionLength: "dimensionLength",
      dimensionThickness: "dimensionThickness",
      dimensionWidth: "dimensionWidth",
      installationVoltageRating: "installationVoltageRating",
      maxCurrent: "maxCurrent",
      maxFuseRating: "maxFuseRating",
      maxPowerRating: "maxPowerRating",
      maxPowerTolerance: "maxPowerTolerance",
      maxSystemVoltage: "maxSystemVoltage",
      maxVoltage: "maxVoltage",
      modelType: "modelType",
      nominalOperatingTemp: "nominalOperatingTemp",
      numberOfPanels: "numberOfPanels",
      openCctVoltage: "openCctVoltage",
      weight: "weight",
    );

    final solarInstallationWeather = SolarInstallationWeather(
      id: "id",
    );

    final SolarInstallationNote solarInstallationNote1 =
        new SolarInstallationNote(
      id: "author",
      note: "note",
      timestamp: "timestamp",
    );

    final SolarInstallationNote solarInstallationNote2 =
        new SolarInstallationNote(
      id: "author",
      note: "note",
      timestamp: "timestamp",
    );

    final SolarInstallationNote solarInstallationNote3 =
        new SolarInstallationNote(
      id: "author",
      note: "note",
      timestamp: "timestamp",
    );

    List<SolarInstallationNote> solarInstallationNotes = [];
    solarInstallationNotes.add(solarInstallationNote1);
    solarInstallationNotes.add(solarInstallationNote2);
    solarInstallationNotes.add(solarInstallationNote3);

    final tSolarInstallation = SolarInstallation(
        customerId: "customerId",
        dateOfInstallation: "dateOfInstallation",
        expectedLoad: "expectedLoad",
        gpsLocationLong: "gpsLocationLong",
        gpsLocationLat: "gpsLocationLat",
        inputDCVoltage: "inputDCVoltage",
        numberOfInterventions: "numberOfInterventions",
        solarInstallationBatteryPack: solarInstallationBatteryPack,
        solarInstallationChargeController: solarInstallationChargeController,
        solarInstallationDaq: solarInstallationDaq,
        id: "id",
        solarInstallationInverter: solarInstallationInverterModel,
        solarInstallationPanels: solarInstallationPanels,
        solarInstallationWeather: solarInstallationWeather,
        //solarInstallationNotes: solarInstallationNotes,
        solarInstallationProvider: "solarInstallationProvider",
        companyEmployeeIds: ["1", "2", "3"]);

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.createSolarInstallation(
            solarInstallation: tSolarInstallation);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return true when the call to remote data source is successful',
          () async {
        // arrange
        String accessToken = "accessToken";
        when(mockRemoteDataSource.createSolarInstallation(
                tSolarInstallation, accessToken))
            .thenAnswer((_) async => true);
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => "accessToken");
        // act
        final result = await repository.createSolarInstallation(
            solarInstallation: tSolarInstallation);
        // assert
        verify(mockRemoteDataSource.createSolarInstallation(
            tSolarInstallation, accessToken));
        expect(result, equals(Right(true)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        String accessToken = "accessToken";
        when(mockRemoteDataSource.createSolarInstallation(
                tSolarInstallation, accessToken))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => "accessToken");
        // act
        final result = await repository.createSolarInstallation(
            solarInstallation: tSolarInstallation);
        // assert
        verify(mockRemoteDataSource.createSolarInstallation(
            tSolarInstallation, accessToken));
        expect(result, equals(Left(ServerFailure(UNKNOWN_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return Failure when there is no network', () async {
        // arrange

        // act
        final result = await repository.createSolarInstallation(
            solarInstallation: tSolarInstallation);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure(NETWORK_ERROR))));
      });
    });
  }); //end of top group

  group('deleteSolarInstallation', () {
    String tSolarInstallationId = "solarInstallationId";

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.deleteSolarInstallation(
            solarInstallationId: tSolarInstallationId);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return true when the call to remote data source is successful',
          () async {
        // arrange
        String accessToken = "accessToken";
        when(mockRemoteDataSource.deleteSolarInstallation(
                tSolarInstallationId, accessToken))
            .thenAnswer((_) async => true);
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => "accessToken");
        // act
        final result = await repository.deleteSolarInstallation(
            solarInstallationId: tSolarInstallationId);
        // assert
        verify(mockRemoteDataSource.deleteSolarInstallation(
            tSolarInstallationId, accessToken));
        expect(result, equals(Right(true)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        String accessToken = "accessToken";
        when(mockRemoteDataSource.deleteSolarInstallation(
                tSolarInstallationId, accessToken))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => "accessToken");
        // act
        final result = await repository.deleteSolarInstallation(
            solarInstallationId: tSolarInstallationId);
        // assert
        verify(mockRemoteDataSource.deleteSolarInstallation(
            tSolarInstallationId, accessToken));
        expect(result, equals(Left(ServerFailure(UNKNOWN_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return Failure when there is no network', () async {
        // arrange

        // act
        final result = await repository.deleteSolarInstallation(
            solarInstallationId: tSolarInstallationId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure(NETWORK_ERROR))));
      });
    });
  }); //end of top group
}
