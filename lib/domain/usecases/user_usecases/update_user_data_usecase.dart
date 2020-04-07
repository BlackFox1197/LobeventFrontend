import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/usecases/usecase.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UpdateUserDataUseCase implements UseCase<User, Params> {
  final UserRepository repository;

  UpdateUserDataUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    //get current user first

    //get solarInstallationData
    return await repository.updateUserData(user: params.user);
  }
}

class Params extends Equatable {
  final User user;

  Params({
    @required this.user,
  }) : super([user]);
}
