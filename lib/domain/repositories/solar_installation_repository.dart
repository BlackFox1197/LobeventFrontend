import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class SolarInstallationRepository {
  //returns either a Failure Object if no data received or a SolarInstallation Object with full data
  Future<Either<Failure, List<SolarInstallation>>> getSolarInstallations(
      {@required User user});

  Future<Either<Failure, bool>> createSolarInstallation({
    @required SolarInstallation solarInstallation,
  });

  Future<Either<Failure, bool>> deleteSolarInstallation(
      {@required String solarInstallationId});
}
