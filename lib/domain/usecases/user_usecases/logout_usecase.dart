import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/usecases/usecase.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LogoutUseCase implements UseCase<bool, NoParams> {
  final UserRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logout();
  }
}

class NoParams extends Equatable {}
