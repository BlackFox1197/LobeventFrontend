import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/usecases/usecase.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCurrentUserUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}

class NoParams extends Equatable {}
