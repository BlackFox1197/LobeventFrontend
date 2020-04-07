import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/delete_account_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

//the Repository of the Entity tells the outside world what things are able to do with an instance

abstract class UserRepository {
  /// Registers a new user using the provided [username] and [password]
  Future<Either<Failure, bool>> register(
      {@required User user, @required String password});

  /// deletes(inactivates) a user account
  Future<Either<Failure, bool>> deleteAccount();

  /// logs in a user using his [username] and [password]
  Future<Either<Failure, User>> login(
      {@required String email, @required String password});

  /// Returns whether the [User] is authenticated.
  Future<bool> isAuthenticated();

  /// Returns the current authenticated [User].
  Future<Either<Failure, User>> getCurrentUser();

  /// Resets the password of a [User]
  Future<Either<Failure, bool>> forgotPassword({@required String email});

  /// Updates selected variables of a [User]
  Future<Either<Failure, User>> updateUserData({@required User user});

  /// Logs out the [User]
  Future<Either<Failure, bool>> logout();
}
