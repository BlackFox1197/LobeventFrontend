import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateSolarInstallationEvent extends Equatable {
  UpdateSolarInstallationEvent([List props = const <dynamic>[]]) : super(props);
}

class ShowImmutableSolarInstallationDataEvent
    extends UpdateSolarInstallationEvent {}

class ShowSolarInstallationUpdateTableEvent
    extends UpdateSolarInstallationEvent {}

class SubmitUpdateSolarInstallationEvent extends UpdateSolarInstallationEvent {
  final SolarInstallation solarInstallation;
  SubmitUpdateSolarInstallationEvent(this.solarInstallation);
}
