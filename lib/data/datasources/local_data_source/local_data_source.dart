import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:auditergy_flutter/data/datasources/local_data_source/mobile.dart'
    if (dart.library.html) 'package:auditergy_flutter/data/datasources/local_data_source/browser.dart';
import 'package:meta/meta.dart';

abstract class LocalDataSource {
  Future<bool> initializeLocalDataSource();
  Future<bool> deleteLocalDataSource();
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl();

  // makes sure that local data source is initialized only once
  @override
  Future<bool> initializeLocalDataSource() async {
    if (!isBrowser) {
      final appDocumentDirectory =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    }
    return true;
  }

  @override
  Future<bool> deleteLocalDataSource() async {
    final result = await Hive.deleteFromDisk();
    return true;
  }
}
