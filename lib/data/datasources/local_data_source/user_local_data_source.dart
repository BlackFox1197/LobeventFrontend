import 'dart:convert';

import 'package:auditergy_flutter/data/datasources/local_data_source/local_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

abstract class UserLocalDataSource {
  Future<User> getCurrentUser();

  Future<void> cacheCurrentUser(User userToCache);

  Future<void> deleteCurrentUserFromCache();

  Future<void> cacheAccessToken(String accessToken);

  Future<void> cacheRefreshToken(String refreshToken);

  Future<String> getAccessToken();

  Future<String> getRefreshToken();

  Future<void> deleteAccessTokenFromCache();

  Future<void> deleteRefreshTokenFromCache();

  Future<void> logout();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final String boxName;
  final HiveInterface hiveDb;

  UserLocalDataSourceImpl({@required this.boxName, @required this.hiveDb});

  @override
  Future<void> cacheCurrentUser(User userToCache) async {
    final box = await hiveDb.openBox(boxName);
    print("got into cache function");
    print("user Runtime Type");
    print(userToCache.runtimeType.toString());

    if (userToCache is CompanyAdminModel || userToCache is CompanyAdmin) {
      print("found company admin");
      CompanyAdminModel userModelToCache =
          CompanyAdminModel.FromCompanyAdmin(userToCache);
      box.put(
          CACHED_USER,
          json.encode(
            userModelToCache.toJson(),
          ));
    } else if (userToCache is CompanyEmployeeModel ||
        userToCache is CompanyEmployee) {
      CompanyEmployeeModel userModelToCache =
          CompanyEmployeeModel.FromCompanyEmployee(userToCache);
      box.put(
          CACHED_USER,
          json.encode(
            userModelToCache.toJson(),
          ));
    } else {
      CustomerModel userModelToCache = CustomerModel.FromCustomer(userToCache);
      box.put(
          CACHED_USER,
          json.encode(
            userModelToCache.toJson(),
          ));
    }
    return hiveDb.box(boxName).close();
  }

  @override
  Future<User> getCurrentUser() async {
    bool debugMode = false;
    if (debugMode == true) {
      final tuser = CustomerModel(
        firstname: "firstname",
        lastname: "lastname",
        email: "email",
        id: "96a5ff7e-3373-4164-87dd-8e3881e8d839",
        country: "country",
        state: "state",
        postalcode: "postalcode",
        street: "street",
        houseNumber: "houseNumber",
        phoneNumber: "phoneNumber",
        solarServiceProviderId: "solarServiceProviderId",
      );
      /* final tuser = CompanyEmployeeModel(
    firstname: "firstname",
    lastname: "lastname",
    uid: "uid",
    email: "email",
    country: "country",
    state: "state",
    postalcode: "postalcode",
    street: "street",
    houseNumber: "houseNumber",
    phoneNumber: "phoneNumber",
    companyId: "companyId",
  );*/
      /* final tuser = CompanyAdminModel(
    firstname: "firstname",
    lastname: "lastname",
    uid: "uid",
    email: "email",
    country: "country",
    state: "state",
    postalcode: "postalcode",
    street: "street",
    houseNumber: "houseNumber",
    phoneNumber: "phoneNumber",
    companyName: "companyName",
    companyWebsite: "companyWebsite",
    companyEmployeesIds: ["1", "2", "3"],);*/
      return tuser;
    } else {}

    final box = await hiveDb.openBox(boxName);
    final jsonString = box.get(CACHED_USER);
    await hiveDb.box(boxName).close();

    if (jsonString != null) {
      final jsonObject = json.decode(jsonString);
      if (jsonObject.containsKey('companyName')) {
        // parse the CompanyAdminModel
        return Future.value(
            CompanyAdminModel.fromJson(json.decode(jsonString)));
      } else if (jsonObject.containsKey('companyId')) {
        // parse the CompanyEmployeeModel
        return Future.value(
            CompanyEmployeeModel.fromJson(json.decode(jsonString)));
      } else {
        // parse the CustomerModel
        return Future.value(CustomerModel.fromJson(json.decode(jsonString)));
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteCurrentUserFromCache() async {
    final box = await hiveDb.openBox(boxName);
    box.delete(CACHED_USER);
    return hiveDb.box(boxName).close();
  }

  @override
  Future<void> cacheAccessToken(String accessToken) async {
    final box = await hiveDb.openBox(TOKEN_BOX_NAME);
    box.put(ACCESS_TOKEN, accessToken);
    return hiveDb.box(TOKEN_BOX_NAME).close();
  }

  @override
  Future<void> cacheRefreshToken(String refreshToken) async {
    final box = await hiveDb.openBox(TOKEN_BOX_NAME);
    box.put(REFRESH_TOKEN, refreshToken);
    return hiveDb.box(TOKEN_BOX_NAME).close();
  }

  @override
  Future<String> getAccessToken() async {
    final box = await hiveDb.openBox(TOKEN_BOX_NAME);
    final accessTokenString = box.get(ACCESS_TOKEN);
    await hiveDb.box(TOKEN_BOX_NAME).close();
    if (accessTokenString != null) {
      return accessTokenString;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getRefreshToken() async {
    final box = await hiveDb.openBox(TOKEN_BOX_NAME);
    final refreshTokenString = box.get(ACCESS_TOKEN);
    await hiveDb.box(TOKEN_BOX_NAME).close();
    if (refreshTokenString != null) {
      return refreshTokenString;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAccessTokenFromCache() async {
    final box = await hiveDb.openBox(TOKEN_BOX_NAME);
    box.delete(ACCESS_TOKEN);
    return hiveDb.box(TOKEN_BOX_NAME).close();
  }

  @override
  Future<void> deleteRefreshTokenFromCache() async {
    final box = await hiveDb.openBox(TOKEN_BOX_NAME);
    box.delete(REFRESH_TOKEN);
    return hiveDb.box(TOKEN_BOX_NAME).close();
  }

  @override
  Future<void> logout() async {
    //delete user and tokens from cache
    try {
      await deleteCurrentUserFromCache();
      await deleteAccessTokenFromCache();
      return Future.value();
    } catch (e) {
      throw CacheException();
    }
  }
}
