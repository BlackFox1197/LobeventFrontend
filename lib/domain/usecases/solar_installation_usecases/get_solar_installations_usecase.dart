import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/usecases/usecase.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetSolarInstallationsUseCase
    implements UseCase<List<SolarInstallation>, Params> {
  final SolarInstallationRepository repository;

  GetSolarInstallationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<SolarInstallation>>> call(Params params) async {
    //returns a list of all solar installation objects of the overgiven user object
    return await repository.getSolarInstallations(user: params.user);
  }
}

class Params extends Equatable {
  final User user;

  Params({@required this.user}) : super([user]);
}
