import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CreateSolarInstallationState extends Equatable {
  CreateSolarInstallationState([List props = const <dynamic>[]]) : super(props);
}

class CreateSolarInstallationInitializedState
    extends CreateSolarInstallationState {
  final User currentUser;

  CreateSolarInstallationInitializedState({@required this.currentUser});

  @override
  List<Object> get props => [];
}

class CreateSolarInstallationUninitializedState
    extends CreateSolarInstallationState {}

class CreateSolarInstallationLoadingState extends CreateSolarInstallationState {
}

class CreateSolarInstallationSuccessState extends CreateSolarInstallationState {
}

class CreateSolarInstallationErrorState extends CreateSolarInstallationState {
  final String errorMessage;

  CreateSolarInstallationErrorState({@required this.errorMessage})
      : super([errorMessage]);
}
