import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:equatable/equatable.dart';

abstract class DeleteSolarInstallationEvent extends Equatable {
  DeleteSolarInstallationEvent([List props = const <dynamic>[]]) : super(props);
}

class DisplayExistingSolarInstallationEvent
    extends DeleteSolarInstallationEvent {}

class SubmitDeleteSolarInstallationEvent extends DeleteSolarInstallationEvent {
  final String solarInstallationId;
  SubmitDeleteSolarInstallationEvent(this.solarInstallationId);
}
