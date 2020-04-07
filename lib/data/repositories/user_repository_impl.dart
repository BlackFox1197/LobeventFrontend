import 'package:auditergy_flutter/data/datasources/local_data_source/user_local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/remote_data_source/user_remote_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/network/network_info.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, bool>> forgotPassword({String email}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAcknowledgement =
            await remoteDataSource.forgotPassword(email);
        if (remoteAcknowledgement == true) {
          return Right(true);
        } else {
          throw ServerException(UNKNOWN_ERROR);
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      //if no network connection is available return a ServerFailure()
      return Left(ServerFailure(NETWORK_ERROR));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final localUserObject = await localDataSource.getCurrentUser();
      return Right(localUserObject);
    } on CacheException {
      return Left(CacheFailure(CACHE_ERROR));
    }
  }

  @override
  Future<Either<Failure, User>> login({String email, String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final List returnedObjects =
            await remoteDataSource.login(email, password);
        if (returnedObjects == null) {
          print("retured Object = null");
          return Left(NullFailure(NULL_INSTANCE_USER));
        } else {
          localDataSource.cacheCurrentUser(returnedObjects[0]);
          localDataSource.cacheAccessToken(returnedObjects[1]);
          return Right(returnedObjects[0]);
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure(NETWORK_ERROR));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await localDataSource.logout();
      return Right(true);
    } on CacheException {
      return Left(CacheFailure(CACHE_ERROR));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final localUserObject = await localDataSource.getCurrentUser();
        try {
          final returnedServerAnswer =
              await remoteDataSource.deleteAccount(localUserObject);
          return Right(returnedServerAnswer);
        } on ServerException catch (e) {
          return Left(ServerFailure(e.message));
        }
      } on CacheException {
        return Left(CacheFailure(CACHE_ERROR));
      }
    } else {
      //if no network connection is available return ServerFailure()
      return Left(ServerFailure(NETWORK_ERROR));
    }
  }

  @override
  Future<Either<Failure, bool>> register({User user, String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final returnedServerAnswer =
            await remoteDataSource.register(user, password);
        print(returnedServerAnswer);
        return Right(returnedServerAnswer);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      //if no network connection is available return ServerFailure()
      return Left(ServerFailure(NETWORK_ERROR));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserData({User user}) async {
    if (await networkInfo.isConnected) {
      try {
        // get tokens and object and put into list for transfer
        //!(IV) trying to test the usecase getting the access token was a problem
        String accessToken = "test"; //await localDataSource.getAccessToken();
        List updateUserCredentials = [user, accessToken];

        final serverResponse =
            await remoteDataSource.updateUserData(updateUserCredentials);
        print("server responce in Update User Data user repo");
        print(serverResponse.runtimeType.toString());
        //update local user in cache
        await localDataSource.cacheCurrentUser(serverResponse);
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
  Future<bool> isAuthenticated() async {
    // user is only authenticated if he has logged in before -> if user object is in local database
    try {
      User user = await localDataSource.getCurrentUser();
      return true;
    } on CacheException {
      return false;
    }
  }
}
