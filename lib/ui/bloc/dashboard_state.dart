import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DashboardState extends Equatable {
  DashboardState([List props = const <dynamic>[]]) : super(props);
}

//uninitialized
class DashboardUninitializedState extends DashboardState {}

//loading
class DashboardLoadingState extends DashboardState {}

//error
class DashboardErrorState extends DashboardState {
  final String errorMessage;

  DashboardErrorState({@required this.errorMessage}) : super([errorMessage]);
}

//initialized
class DashboardInitializedState extends DashboardState {
  final List<SolarInstallation> solarInstallationList;

  DashboardInitializedState({@required this.solarInstallationList});

  @override
  List<Object> get props => [];
}

//create new installation
class CreateSolarInstallationPageState extends DashboardState {}

//view single solar installation
class SingleInstallationPageState extends DashboardState {
  final SolarInstallation solarInstallation;

  SingleInstallationPageState({@required this.solarInstallation});

  @override
  List<Object> get props => [];
}
