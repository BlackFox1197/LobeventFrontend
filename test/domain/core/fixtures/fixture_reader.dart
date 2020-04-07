import 'dart:io';

String fixture(String name) =>
    File('test/domain/core/fixtures/$name').readAsStringSync();
