import 'dart:async';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/util/input_converter.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/forgot_password_usecase.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import './user_bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc({@required ForgotPasswordUseCase forgotPassword})
      : assert(forgotPassword != null),
        forgotPasswordUseCase = forgotPassword;

  @override
  ForgotPasswordState get initialState => ForgotPasswordEmptyState();

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordRecoverEvent) {
      yield ForgotPasswordLoadingState();
      final failureOrSuccess =
          await forgotPasswordUseCase.call(Params(email: event.email));
      print("forgotPasswordRecoverEvent");

      yield* _eitherLoadedOrErrorState(failureOrSuccess, event.email);
    } else if (event is ForgotPasswordShowUiEvent) {
      yield InitialForgotPasswordState();
    } else if (event is ForgotPasswordCloseUiEvent) {
      yield ForgotPasswordEmptyState();
    }
  }

  Stream<ForgotPasswordState> _eitherLoadedOrErrorState(
      Either<Failure, bool> failureOrSuccess, String email) async* {
    print("failure or success");
    yield failureOrSuccess.fold(
        (failure) =>
            ErrorForgotPasswordState(message: _mapFailureToMessage(failure)),
        (success) => ForgotPasswordRecoverdState(email: email));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Password recovery failed. " + SERVER_FAILURE_MESSAGE;
      case InvalidInputFailure:
        return INVALID_INPUT_FAILURE_MESSAGE;
      default:
        return UNKNOWN_ERROR;
    }
  }
}
