import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UpdateSolarInstallationState extends Equatable {
  UpdateSolarInstallationState([List props = const <dynamic>[]]) : super(props);
}

class ShowImmutableSolarInstallationDataState
    extends UpdateSolarInstallationState {}

class UpdateSolarInstallationLoadingState extends UpdateSolarInstallationState {
}

class UpdateSolarInstallationDataState extends UpdateSolarInstallationState {}

class UpdateSolarInstallationErrorState extends UpdateSolarInstallationState {
  final String errorMessage;

  UpdateSolarInstallationErrorState({@required this.errorMessage})
      : super([errorMessage]);
}
