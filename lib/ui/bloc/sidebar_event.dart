import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class SidebarEvent extends Equatable {
  SidebarEvent([List props = const <dynamic>[]]) : super(props);
}

class InitializeSidebarEvent extends SidebarEvent {}

/* class SubmitSolarInstallationFormEvent extends SidebarEvent {
  final SolarInstallation solarInstallation;
  SubmitSolarInstallationFormEvent(this.solarInstallation);
} */
