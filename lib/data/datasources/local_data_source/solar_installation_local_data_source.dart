import 'dart:convert';

import 'package:auditergy_flutter/data/datasources/local_data_source/local_data_source.dart';
import 'package:auditergy_flutter/data/models/solar_installation_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

abstract class SolarInstallationLocalDataSource {
  /// Gets the [SolarInstallationModel] which was gotten the last time the user had an internet connection
  ///
  /// Throws a [CacheException] if no cached data is present.
  Future<List<SolarInstallationModel>> getCachedSolarInstallations();

  Future<void> cacheSolarInstallations(
      List<SolarInstallationModel> solarInstallationModelsToCache);

  Future<String> getAccessToken();

  Future<String> getRefreshToken();
}

class SolarInstallationLocalDataSourceImpl
    implements SolarInstallationLocalDataSource {
  final String boxName;
  final HiveInterface hiveDb;

  SolarInstallationLocalDataSourceImpl(
      {@required this.boxName, @required this.hiveDb});

  // way to go for caching data -> Hive.openBox("boxName") -> do your stuf -> Hive.box("boxName").close() => do this in every method to stay clean

  @override
  Future<List<SolarInstallationModel>> getCachedSolarInstallations() async {
    // open the local datasource and choose the right box
    final box = await hiveDb.openBox(boxName);
    final jsonString = box.get(CACHED_SOLAR_INSTALLATIONS);
    if (jsonString != null) {
      List allSolarInstallationsFromCache = json.decode(jsonString);
      List<SolarInstallationModel> solarInstallationsList =
          allSolarInstallationsFromCache
              .map((solarInstallation) =>
                  SolarInstallationModel.fromJson(solarInstallation))
              .toList();
      // close the local datasource directly after access to safe memory
      await hiveDb.box(boxName).close();
      return Future.value(solarInstallationsList);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSolarInstallations(
      List<SolarInstallationModel> solarInstallationModelsToCache) async {
    final box = await hiveDb.openBox(boxName);

    List<Map> jsonObjects = [];
    for (int i = 0; i < solarInstallationModelsToCache.length; i++) {
      jsonObjects.add(solarInstallationModelsToCache[i].toJson());
    }

    box.put(CACHED_SOLAR_INSTALLATIONS, json.encode(jsonObjects));
    return hiveDb.box(boxName).close();
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
}
