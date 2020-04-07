import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/usecases/usecase.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class RegisterUseCase implements UseCase<bool, Params> {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    //get current user first

    //get solarInstallationData
    return await repository.register(
        user: params.user, password: params.password);
  }
}

class Params extends Equatable {
  final User user;
  final String password;

  Params({@required this.user, @required this.password})
      : super([user, password]);
}
