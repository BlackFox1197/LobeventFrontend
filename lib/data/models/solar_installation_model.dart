import 'package:auditergy_flutter/data/models/solar_installation_battery_pack_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_charge_controller_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_daq_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_inverter_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_note_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_panels_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_weather_model.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_battery_pack.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_charge_controller.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_daq.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_inverter.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_note.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_panels.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation_weather.dart';
import 'package:meta/meta.dart';

class SolarInstallationModel extends SolarInstallation {
  SolarInstallationModel({
    @required String customerId,
    @required String dateOfInstallation,
    @required String expectedLoad,
    @required String gpsLocationLong,
    @required String gpsLocationLat,
    @required String inputDCVoltage,
    @required String numberOfInterventions,
    @required SolarInstallationBatteryPack solarInstallationBatteryPack,
    @required
        SolarInstallationChargeController solarInstallationChargeController,
    @required SolarInstallationDaq solarInstallationDaq,
    @required String id,
    @required SolarInstallationInverter solarInstallationInverter,
    @required SolarInstallationPanels solarInstallationPanels,
    @required SolarInstallationWeather solarInstallationWeather,
    //TODO -> implement the solar installation notes as a chronological list
    //@required List<SolarInstallationNote> solarInstallationNotes,
    @required String solarInstallationProvider,
    @required List<String> companyEmployeeIds,
  }) : super(
          customerId: customerId,
          dateOfInstallation: dateOfInstallation,
          expectedLoad: expectedLoad,
          gpsLocationLong: gpsLocationLong,
          gpsLocationLat: gpsLocationLat,
          inputDCVoltage: inputDCVoltage,
          numberOfInterventions: numberOfInterventions,
          solarInstallationBatteryPack: solarInstallationBatteryPack,
          solarInstallationChargeController: solarInstallationChargeController,
          solarInstallationDaq: solarInstallationDaq,
          id: id,
          solarInstallationInverter: solarInstallationInverter,
          solarInstallationPanels: solarInstallationPanels,
          solarInstallationWeather: solarInstallationWeather,
          //solarInstallationNotes: solarInstallationNotes,
          solarInstallationProvider: solarInstallationProvider,
          companyEmployeeIds: companyEmployeeIds,
        );

  factory SolarInstallationModel.FromSolarInstallation(
      SolarInstallation solarInstallation) {
    return SolarInstallationModel(
      customerId: solarInstallation.customerId,
      dateOfInstallation: solarInstallation.dateOfInstallation,
      expectedLoad: solarInstallation.expectedLoad,
      gpsLocationLong: solarInstallation.gpsLocationLong,
      gpsLocationLat: solarInstallation.gpsLocationLat,
      inputDCVoltage: solarInstallation.inputDCVoltage,
      numberOfInterventions: solarInstallation.numberOfInterventions,
      solarInstallationBatteryPack:
          solarInstallation.solarInstallationBatteryPack,
      solarInstallationChargeController:
          solarInstallation.solarInstallationChargeController,
      solarInstallationDaq: solarInstallation.solarInstallationDaq,
      id: solarInstallation.id,
      solarInstallationInverter: solarInstallation.solarInstallationInverter,
      solarInstallationPanels: solarInstallation.solarInstallationPanels,
      solarInstallationWeather: solarInstallation.solarInstallationWeather,
      //solarInstallationNotes: solarInstallationNotes,
      solarInstallationProvider: solarInstallation.solarInstallationProvider,
      companyEmployeeIds: solarInstallation.companyEmployeeIds,
    );
  }

  factory SolarInstallationModel.fromJson(Map<String, dynamic> json) {
    var solarInstallationBatteryPackJson = json['solarInstallationBatteryPack'];
    SolarInstallationBatteryPack batteryPackConvert(jsonString) {
      SolarInstallationBatteryPackModel model = jsonString != null
          ? SolarInstallationBatteryPackModel.fromJson(jsonString)
          : null;
      return SolarInstallationBatteryPack(
        batteryPackVoltage: model.batteryPackVoltage,
        batteryUnitCurrentRating: model.batteryUnitCurrentRating,
        batteryUnitVoltageRating: model.batteryUnitVoltageRating,
        manufacturer: model.manufacturer,
        numberOfBatteries: model.numberOfBatteries,
        type: model.type,
      );
    }

    SolarInstallationBatteryPack solarInstallationBatteryPack =
        batteryPackConvert(solarInstallationBatteryPackJson);

    var solarInstallationChargeControllerJson =
        json['solarInstallationChargeController'];
    SolarInstallationChargeController chargeControllerConvert(jsonString) {
      SolarInstallationChargeControllerModel model = jsonString != null
          ? SolarInstallationChargeControllerModel.fromJson(jsonString)
          : null;
      return SolarInstallationChargeController(
        boostDuration: model.boostDuration,
        boostReturnVoltage: model.boostReturnVoltage,
        dischargeCurrent: model.dischargeCurrent,
        dischargeReconnect: model.dischargeReconnect,
        dischargeStop: model.dischargeStop,
        equalizationVoltage: model.equalizationVoltage,
        floatChargeVoltage: model.floatChargeVoltage,
        highVoltageDisconnect: model.highVoltageDisconnect,
        manufacturer: model.manufacturer,
        maxSolarInput: model.maxSolarInput,
        model: model.model,
        operatingTemperature: model.operatingTemperature,
        type: model.type,
      );
    }

    SolarInstallationChargeController solarInstallationChargeController =
        chargeControllerConvert(solarInstallationChargeControllerJson);

    var solarInstallationDAQJson = json['solarInstallationDaq'];
    SolarInstallationDaq daqConvert(jsonString) {
      SolarInstallationDaqModel model = jsonString != null
          ? SolarInstallationDaqModel.fromJson(jsonString)
          : null;
      return SolarInstallationDaq(
        id: model.id,
        daqMeasurement: model.daqMeasurement,
      );
    }

    SolarInstallationDaq solarInstallationDaq =
        daqConvert(solarInstallationDAQJson);

    var solarInstallationInverterJson = json['solarInstallationInverter'];
    SolarInstallationInverter inverterConvert(jsonString) {
      SolarInstallationInverterModel model = jsonString != null
          ? SolarInstallationInverterModel.fromJson(jsonString)
          : null;
      return SolarInstallationInverter(
        inputDCVoltage: model.inputDCVoltage,
        kvaRating: model.kvaRating,
        manufacturer: model.manufacturer,
        outputACVoltage: model.outputACVoltage,
        outputFrequency: model.outputFrequency,
      );
    }

    SolarInstallationInverter solarInstallationInverter =
        inverterConvert(solarInstallationInverterJson);

    //solar installation panels
    var solarInstallationPanelsJson = json['solarInstallationPanels'];
    SolarInstallationPanels panelsConvert(jsonString) {
      SolarInstallationPanelsModel model = jsonString != null
          ? SolarInstallationPanelsModel.fromJson(jsonString)
          : null;
      return SolarInstallationPanels(
        dimensionLength: model.dimensionLength,
        dimensionThickness: model.dimensionThickness,
        dimensionWidth: model.dimensionWidth,
        installationVoltageRating: model.installationVoltageRating,
        maxCurrent: model.maxCurrent,
        maxFuseRating: model.maxFuseRating,
        maxPowerRating: model.maxPowerRating,
        maxPowerTolerance: model.maxPowerTolerance,
        maxSystemVoltage: model.maxSystemVoltage,
        maxVoltage: model.maxVoltage,
        modelType: model.modelType,
        nominalOperatingTemp: model.nominalOperatingTemp,
        numberOfPanels: model.numberOfPanels,
        openCctVoltage: model.openCctVoltage,
        weight: model.weight,
      );
    }

    SolarInstallationPanels solarInstallationPanels =
        panelsConvert(solarInstallationPanelsJson);

    //solar installation weather
    var solarInstallationWeatherJson = json['solarInstallationWeather'];
    SolarInstallationWeather weatherConvert(jsonString) {
      SolarInstallationWeatherModel model = jsonString != null
          ? SolarInstallationWeatherModel.fromJson(jsonString)
          : null;
      return SolarInstallationWeather(
        id: model.id,
      );
    }

    SolarInstallationWeather solarInstallationWeather =
        weatherConvert(solarInstallationWeatherJson);

    var solarInstallationNotesJson = json['solarInstallationNotes'] as List;
    SolarInstallationNote noteConvert(jsonString) {
      SolarInstallationNoteModel model = jsonString != null
          ? SolarInstallationNoteModel.fromJson(jsonString)
          : null;
      return SolarInstallationNote(
        id: model.id,
        note: model.note,
        timestamp: model.timestamp,
      );
    }

    List<SolarInstallationNote> solarInstallationNotes =
        solarInstallationNotesJson != null
            ? solarInstallationNotesJson.map((i) => noteConvert(i)).toList()
            : null;

    var companyEmployeeIdsJson = json['companyEmployeeIds'];
    List<String> companyEmployeeIds = companyEmployeeIdsJson != null
        ? new List<String>.from(companyEmployeeIdsJson)
        : null;

    return SolarInstallationModel(
      customerId: json['customerId'],
      dateOfInstallation: json['dateOfInstallation'],
      expectedLoad: json['expectedLoad'],
      gpsLocationLong: json['gpsLocationLong'],
      gpsLocationLat: json['gpsLocationLat'],
      inputDCVoltage: json['inputDCVoltage'],
      numberOfInterventions: json['numberOfInterventions'],
      solarInstallationBatteryPack: solarInstallationBatteryPack,
      solarInstallationChargeController: solarInstallationChargeController,
      solarInstallationDaq: solarInstallationDaq,
      id: json['id'],
      solarInstallationInverter: solarInstallationInverter,
      solarInstallationPanels: solarInstallationPanels,
      solarInstallationWeather: solarInstallationWeather,
      //solarInstallationNotes: solarInstallationNotes,
      //TODO: Spelling mistake from API ...
      solarInstallationProvider: json['solarInstalltionProvider'],
      companyEmployeeIds: companyEmployeeIds,
    );
  }

  Map<String, dynamic> toJson() {
    SolarInstallationBatteryPackModel solarInstallationBatteryPackModel =
        new SolarInstallationBatteryPackModel(
            batteryPackVoltage: solarInstallationBatteryPack.batteryPackVoltage,
            batteryUnitCurrentRating:
                solarInstallationBatteryPack.batteryUnitCurrentRating,
            batteryUnitVoltageRating:
                solarInstallationBatteryPack.batteryUnitVoltageRating,
            manufacturer: solarInstallationBatteryPack.manufacturer,
            numberOfBatteries: solarInstallationBatteryPack.numberOfBatteries,
            type: solarInstallationBatteryPack.type);
    Map<String, dynamic> solarInstallationBatteryPackJson =
        solarInstallationBatteryPackModel != null
            ? solarInstallationBatteryPackModel.toJson()
            : null;
//
    SolarInstallationChargeControllerModel
        solarInstallationChargeControllerModel =
        new SolarInstallationChargeControllerModel(
            boostDuration: solarInstallationChargeController.boostDuration,
            dischargeCurrent:
                solarInstallationChargeController.dischargeCurrent,
            boostReturnVoltage:
                solarInstallationChargeController.boostReturnVoltage,
            dischargeReconnect:
                solarInstallationChargeController.dischargeReconnect,
            dischargeStop: solarInstallationChargeController.dischargeStop,
            equalizationVoltage:
                solarInstallationChargeController.equalizationVoltage,
            floatChargeVoltage:
                solarInstallationChargeController.floatChargeVoltage,
            highVoltageDisconnect:
                solarInstallationChargeController.highVoltageDisconnect,
            manufacturer: solarInstallationChargeController.manufacturer,
            maxSolarInput: solarInstallationChargeController.maxSolarInput,
            model: solarInstallationChargeController.model,
            operatingTemperature:
                solarInstallationChargeController.operatingTemperature,
            type: solarInstallationChargeController.type);
    Map<String, dynamic> solarInstallationChargeControllerJson =
        solarInstallationChargeControllerModel != null
            ? solarInstallationChargeControllerModel.toJson()
            : null;
//
    SolarInstallationDaqModel solarInstallationDaqModel =
        new SolarInstallationDaqModel(
            daqMeasurement: solarInstallationDaq.daqMeasurement,
            id: solarInstallationDaq.id);
    Map<String, dynamic> solarInstallationDaqJson =
        solarInstallationDaqModel != null
            ? solarInstallationDaqModel.toJson()
            : null;

    SolarInstallationInverterModel solarInstallationInverterModel =
        new SolarInstallationInverterModel(
            inputDCVoltage: solarInstallationInverter.inputDCVoltage,
            kvaRating: solarInstallationInverter.kvaRating,
            manufacturer: solarInstallationInverter.manufacturer,
            outputACVoltage: solarInstallationInverter.outputACVoltage,
            outputFrequency: solarInstallationInverter.outputFrequency);
    Map<String, dynamic> solarInstallationInverterJson =
        solarInstallationInverterModel != null
            ? solarInstallationInverterModel.toJson()
            : null;

    SolarInstallationPanelsModel solarInstallationPanelsModel =
        new SolarInstallationPanelsModel(
            dimensionLength: solarInstallationPanels.dimensionLength,
            dimensionThickness: solarInstallationPanels.dimensionThickness,
            dimensionWidth: solarInstallationPanels.dimensionWidth,
            installationVoltageRating:
                solarInstallationPanels.installationVoltageRating,
            maxCurrent: solarInstallationPanels.maxCurrent,
            maxFuseRating: solarInstallationPanels.maxFuseRating,
            maxPowerRating: solarInstallationPanels.maxPowerRating,
            maxPowerTolerance: solarInstallationPanels.maxPowerTolerance,
            maxSystemVoltage: solarInstallationPanels.maxSystemVoltage,
            maxVoltage: solarInstallationPanels.maxVoltage,
            modelType: solarInstallationPanels.modelType,
            nominalOperatingTemp: solarInstallationPanels.nominalOperatingTemp,
            numberOfPanels: solarInstallationPanels.numberOfPanels,
            openCctVoltage: solarInstallationPanels.openCctVoltage,
            weight: solarInstallationPanels.weight);
    Map<String, dynamic> solarInstallationPanelsJson =
        solarInstallationPanelsModel != null
            ? solarInstallationPanelsModel.toJson()
            : null;

    SolarInstallationWeatherModel solarInstallationWeatherModel =
        new SolarInstallationWeatherModel(id: solarInstallationWeather.id);
    Map<String, dynamic> solarInstallationWeatherJson =
        solarInstallationWeatherModel != null
            ? solarInstallationWeatherModel.toJson()
            : null;

/*     List<SolarInstallationNoteModel> solarInstallationNotesModels =
        solarInstallationNotes != null
            ? solarInstallationNotes
                .map((i) => new SolarInstallationNoteModel(
                    id: i.id, note: i.note, timestamp: i.timestamp))
                .toList()
            : null;
    List<Map<String, dynamic>> solarInstallationNotesJson =
        solarInstallationNotesModels != null
            ? solarInstallationNotesModels.map((i) => i.toJson()).toList()
            : null; */

    return {
      "customerId": customerId,
      "dateOfInstallation": dateOfInstallation,
      "expectedLoad": expectedLoad,
      "gpsLocationLong": gpsLocationLong,
      "gpsLocationLat": gpsLocationLat,
      "inputDCVoltage": inputDCVoltage,
      "numberOfInterventions": numberOfInterventions,
      "solarInstallationBatteryPack": solarInstallationBatteryPackJson,
      "solarInstallationChargeController":
          solarInstallationChargeControllerJson,
      "solarInstallationDaq": solarInstallationDaqJson,
      "id": id,
      "solarInstallationInverter": solarInstallationInverterJson,
      "solarInstallationPanels": solarInstallationPanelsJson,
      "solarInstallationWeather": solarInstallationWeatherJson,
      //"solarInstallationNotes": solarInstallationNotesJson,
      //TODO: Spelling mistake from API ...
      "solarInstalltionProvider": solarInstallationProvider,
      "companyEmployeeIds": companyEmployeeIds
    };
  }
}
