import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CreateSolarInstallationEvent extends Equatable {
  CreateSolarInstallationEvent([List props = const <dynamic>[]]) : super(props);
}

class InitializeSolarInstallationFormEvent
    extends CreateSolarInstallationEvent {}

class SubmitSolarInstallationFormEvent extends CreateSolarInstallationEvent {
  final SolarInstallation solarInstallation;
  SubmitSolarInstallationFormEvent(this.solarInstallation);
}
