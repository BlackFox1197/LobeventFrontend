import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/usecases/usecase.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DeleteSolarInstallationUseCase implements UseCase<bool, Params> {
  final SolarInstallationRepository repository;

  DeleteSolarInstallationUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    //returns a list of all solar installation objects of the overgiven user object
    return await repository.deleteSolarInstallation(
        solarInstallationId: params.solarInstallationId);
  }
}

class Params extends Equatable {
  final String solarInstallationId;

  Params({@required this.solarInstallationId}) : super([solarInstallationId]);
}
