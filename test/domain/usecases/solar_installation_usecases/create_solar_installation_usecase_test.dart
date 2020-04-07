import 'package:auditergy_flutter/domain/entities/daq_measurement.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/create_solar_installation_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSolarInstallationRepository extends Mock
    implements SolarInstallationRepository {}

void main() {
  CreateSolarInstallationUseCase usecase;
  MockSolarInstallationRepository mockSolarInstallationRepository;

  setUp(() {
    mockSolarInstallationRepository = MockSolarInstallationRepository();
    usecase = CreateSolarInstallationUseCase(mockSolarInstallationRepository);
  });
  final SolarInstallationBatteryPack solarInstallationBatteryPack =
      new SolarInstallationBatteryPack(
    batteryPackVoltage: "batteryPackVoltage",
    batteryUnitCurrentRating: "batteryUnitCurrentRating",
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
    manufacturer: "manufacturer",
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
    id: "id",
    note: "note",
    timestamp: "timestamp",
  );

  final SolarInstallationNote solarInstallationNote2 =
      new SolarInstallationNote(
    id: "id",
    note: "note",
    timestamp: "timestamp",
  );

  final SolarInstallationNote solarInstallationNote3 =
      new SolarInstallationNote(
    id: "id",
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
  test(
    'should  create a solar installation',
    () async {
      //arrange
      Params p = new Params(solarInstallation: tSolarInstallation);
      when(mockSolarInstallationRepository.createSolarInstallation(
              solarInstallation: p.solarInstallation))
          .thenAnswer((_) async => Right(true));
      //act
      Params p1 = new Params(solarInstallation: tSolarInstallation);
      final result = await usecase(p1);
      //assert
      expect(result, Right(true));
      verify(mockSolarInstallationRepository.createSolarInstallation(
          solarInstallation: tSolarInstallation));
      verifyNoMoreInteractions(mockSolarInstallationRepository);
    },
  );
}
