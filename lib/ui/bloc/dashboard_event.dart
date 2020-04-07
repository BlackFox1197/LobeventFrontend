import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  DashboardEvent([List props = const <dynamic>[]]) : super(props);
}

class InitializeDashboardEvent extends DashboardEvent {
  //initializing means getting all solar installations for the overgiven user
}

class GoToCreateSolarInstallationPageEvent extends DashboardEvent {}

class GoToSingleSolarInstallationPageEvent extends DashboardEvent {
  final SolarInstallation solarInstallation;
  GoToSingleSolarInstallationPageEvent(this.solarInstallation);
}
