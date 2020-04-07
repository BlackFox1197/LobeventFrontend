import 'package:auditergy_flutter/data/datasources/local_data_source/solar_installation_local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/remote_data_source/solar_installation_remote_data_source.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/network/network_info.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SolarInstallationRepositoryImpl implements SolarInstallationRepository {
  final SolarInstallationRemoteDataSource remoteDataSource;
  final SolarInstallationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SolarInstallationRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SolarInstallation>>> getSolarInstallations(
      {User user}) async {
    if (await networkInfo.isConnected) {
      try {
        String accessToken = "test"; //await localDataSource.getAccessToken();
        final remoteSolarInstallations =
            await remoteDataSource.getSolarInstallations(user, accessToken);
        //localDataSource.cacheSolarInstallations(remoteSolarInstallations);
        return Right(remoteSolarInstallations);
      } on ServerException {
        return Left(ServerFailure(UNKNOWN_ERROR));
      } on CacheException {
        return Left(CacheFailure(CACHE_ERROR));
      }
    } else {
      try {
        final localSolarInstallations =
            await localDataSource.getCachedSolarInstallations();
        return Right(localSolarInstallations);
      } on CacheException {
        return Left(CacheFailure(CACHE_ERROR));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> createSolarInstallation(
      {SolarInstallation solarInstallation}) async {
    if (await networkInfo.isConnected) {
      try {
        // get tokens and object and put into list for transfer
        String accessToken = "test"; //await localDataSource.getAccessToken();
        final serverResponse = await remoteDataSource.createSolarInstallation(
            solarInstallation, accessToken);
        return Right(serverResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      //if no network connection is available return ServerFailure()
      return Left(ServerFailure(NETWORK_ERROR));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteSolarInstallation(
      {String solarInstallationId}) async {
    if (await networkInfo.isConnected) {
      try {
        // get tokens and object and put into list for transfer
        String accessToken = "test"; //await localDataSource.getAccessToken();
        final serverResponse = await remoteDataSource.deleteSolarInstallation(
            solarInstallationId, accessToken);
        return Right(serverResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      //if no network connection is available return ServerFailure()
      return Left(ServerFailure(NETWORK_ERROR));
    }
  }
}
