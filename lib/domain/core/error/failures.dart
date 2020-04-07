import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

//General Failures
class ServerFailure extends Failure {
  final String message;
  ServerFailure(this.message);
}

class NullFailure extends Failure {
  final String message;
  NullFailure(this.message);
}

class CacheFailure extends Failure {
  final String message;
  CacheFailure(this.message);
}
