import 'dart:convert';

import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class SolarInstallationRemoteDataSource {
  /// Calls the flask backend server to get the solar installation data as JSON object
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<SolarInstallationModel>> getSolarInstallations(
      User user, String accessToken);

  Future<bool> createSolarInstallation(
      SolarInstallation solarInstallation, String accessToken);

  Future<bool> deleteSolarInstallation(
      String solarInstallationId, String acessToken);
}

class SolarInstallationRemoteDataSourceImpl
    implements SolarInstallationRemoteDataSource {
  final http.Client client;

  SolarInstallationRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<SolarInstallationModel>> getSolarInstallations(
      User user, String accessToken) async {
    // make the right request appropriate to what specific user we are handling
    if (user is CompanyAdmin) {
      CompanyAdminModel userModel = CompanyAdminModel.FromCompanyAdmin(user);
      //TODO: get token and put to right place
      //create route
      final String uniqueUserInstallationsRoute =
          GET_COMPANY_ADMIN_SOLAR_INSTALLATIONS_URI + "/" + userModel.id;
      final response = await client.get(
        uniqueUserInstallationsRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      );
      if (response.statusCode == 200) {
        //parse the [{},{}] JSON Object Array into a List of SolarInstallationModels
        List allSolarInstallations = json.decode(response.body);
        List<SolarInstallationModel> solarInstallationsList =
            allSolarInstallations
                .map((solarInstallation) =>
                    SolarInstallationModel.fromJson(solarInstallation))
                .toList();
        return solarInstallationsList;
      } else {
        throw ServerException(UNKNOWN_ERROR);
      }
    } else if (user is CompanyEmployee) {
      CompanyEmployeeModel userModel =
          CompanyEmployeeModel.FromCompanyEmployee(user);
      //TODO: get token and put to right place
      //create route
      final String uniqueUserInstallationsRoute =
          GET_COMPANY_EMPLOYEE_SOLAR_INSTALLATIONS_URI + "/" + userModel.id;
      final response = await client.get(
        uniqueUserInstallationsRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      );
      if (response.statusCode == 200) {
        //parse the [{},{}] JSON Object Array into a List of SolarInstallationModels
        List allSolarInstallations = json.decode(response.body);
        List<SolarInstallationModel> solarInstallationsList =
            allSolarInstallations
                .map((solarInstallation) =>
                    SolarInstallationModel.fromJson(solarInstallation))
                .toList();
        return solarInstallationsList;
      } else {
        throw ServerException(UNKNOWN_ERROR);
      }
    } else if (user is Customer) {
      CustomerModel userModel = CustomerModel.FromCustomer(user);
      //TODO: get token and put to right place
      //create route
      final String uniqueUserInstallationsRoute =
          GET_CUSTOMER_SOLAR_INSTALLATIONS_URI + "/" + userModel.id;
      final response = await client.get(
        uniqueUserInstallationsRoute,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
      );
      if (response.statusCode == 200) {
        //parse the [{},{}] JSON Object Array into a List of SolarInstallationModels
        final List allSolarInstallations = json.decode(response.body);
        final List<SolarInstallationModel> solarInstallationsList =
            allSolarInstallations
                .map((solarInstallation) =>
                    SolarInstallationModel.fromJson(solarInstallation))
                .toList();
        return solarInstallationsList;
      } else {
        throw ServerException(UNKNOWN_ERROR);
      }
    } else {
      final emptyList = new List<SolarInstallationModel>();
      return emptyList;
    }
  }

  @override
  Future<bool> createSolarInstallation(
      SolarInstallation solarInstallation, String accessToken) async {
    Map<String, dynamic> request = {};

    SolarInstallationModel solarInstallationModel =
        SolarInstallationModel.FromSolarInstallation(solarInstallation);
    request = solarInstallationModel.toJson();
    //TODO: uniqy companyAdminId and solarInstallationProvider to one variable at backend
    request.putIfAbsent('companyAdminId',
        () => '${solarInstallationModel.solarInstallationProvider}');
    print(request.toString());

    final response = await client.post(CREATE_SOLAR_INSTALLATION_URI,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': API_BASIC_AUTH
        },
        body: json.encode(request));

    // TODO: Figure out method for refresh token -> handling should happen here
    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['status'] == "failure") {
        throw ServerException(responseJson['message']);
      } else if (responseJson['id'] == solarInstallationModel.id) {
        return true;
      } else {
        throw ServerException(UNKNOWN_ERROR);
      }
    } else {
      throw ServerException(SERVER_ERROR);
    }
  }

  @override
  Future<bool> deleteSolarInstallation(
      String solarInstallationId, String accessToken) async {
    //TODO: get token and put to right place
    //create route
    final String uniqueSolarInstallationDeleteRoute =
        DELETE_SOLAR_INSTALLATION_URI + "/" + solarInstallationId;
    final response = await client.delete(
      uniqueSolarInstallationDeleteRoute,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': API_BASIC_AUTH
      },
    );
    // TODO: Figure out method for refresh token -> handling should happen here
    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['status'] == "failure") {
        throw ServerException(responseJson['message']);
      } else if (responseJson['success'] == true) {
        return true;
      } else {
        throw ServerException(UNKNOWN_ERROR);
      }
    } else {
      throw ServerException(SERVER_ERROR);
    }
  }
}
