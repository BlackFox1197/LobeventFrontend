import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/usecases/usecase.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ForgotPasswordUseCase implements UseCase<bool, Params> {
  final UserRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.forgotPassword(email: params.email);
  }
}

class Params extends Equatable {
  final String email;

  Params({@required this.email}) : super([email]);
}
