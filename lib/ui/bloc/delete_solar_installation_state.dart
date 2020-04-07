import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DeleteSolarInstallationState extends Equatable {
  DeleteSolarInstallationState([List props = const <dynamic>[]]) : super(props);
}

class DisplayExisingSolarInstallationState
    extends DeleteSolarInstallationState {}

class DeleteSolarInstallationLoadingState extends DeleteSolarInstallationState {
}

class DeleteSolarInstallationSuccessState extends DeleteSolarInstallationState {
}

class DeleteSolarInstallationErrorState extends DeleteSolarInstallationState {
  final String errorMessage;

  DeleteSolarInstallationErrorState({@required this.errorMessage})
      : super([errorMessage]);
}
