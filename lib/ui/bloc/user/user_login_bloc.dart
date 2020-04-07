import 'dart:async';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/util/input_converter.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/login_usecase.dart'
    as logUseCase;
import 'package:auditergy_flutter/domain/usecases/user_usecases/register_usecase.dart'
    as regUseCase;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import './user_bloc.dart';

// const String SERVER_FAILURE_MESSAGE = SERVER_ERROR;

class UserLoginBloc extends Bloc<AbstractUserLoginEvent, UserLoginState> {
  InputConverter inputConverter;
  final logUseCase.LoginUseCase loginUseCase;
  final regUseCase.RegisterUseCase registerUseCase;

  UserLoginBloc(
      {@required logUseCase.LoginUseCase login,
      @required regUseCase.RegisterUseCase register})
      : assert(login != null),
        assert(register != null),
        loginUseCase = login,
        registerUseCase = register;

  @override
  UserLoginState get initialState => InitialUserLoginState();

  @override
  Stream<UserLoginState> mapEventToState(
    AbstractUserLoginEvent event,
  ) async* {
    if (event is UserLoginEvent) {
      yield UserLoginLoadingState();
      final failureOrUser = await loginUseCase.call(
          logUseCase.Params(email: event.email, password: event.password));
      yield* _eitherLoadedOrErrorLoginState(failureOrUser);
    } else if (event is UserRegisterEvent) {
      yield UserRegisterLoadingState();
      final failureOrSuccess = await registerUseCase.call(
        regUseCase.Params(user: event.user, password: event.password),
      );
      yield* _eitherLoadedOrErrorRegisterState(failureOrSuccess, event.user);
    } else if (event is LoginShowUiEvent) {
      yield InitialUserLoginState();
    } else if (event is ShowRegisterCompanyAdminUiEvent) {
      yield RegisterCompanyAdminState();
    } else if (event is ShowRegisterCustomerUiEvent) {
      yield RegisterCustomerState();
    }
  }

  Stream<UserLoginState> _eitherLoadedOrErrorLoginState(
      Either<Failure, User> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
        (failure) => LoginErrorState(message: _mapFailureToMessage(failure)),
        (user) => UserLoggedInState(user: user));
  }

  Stream<UserLoginState> _eitherLoadedOrErrorRegisterState(
    Either<Failure, bool> failureOrSuccess,
    User user,
  ) async* {
    yield failureOrSuccess.fold(
        (failure) => LoginErrorState(message: _mapFailureToMessage(failure)),
        (success) => UserRegisteredState(user: user));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case WrongCredentialsFailure:
        return WRONG_CREDENTIALS_MESSAGE;
      case InvalidInputFailure:
        return INVALID_INPUT_FAILURE_MESSAGE;
      default:
        return UNKNOWN_ERROR;
    }
  }
}

class WrongCredentialsFailure extends Failure {
  final String message;
  WrongCredentialsFailure(this.message);
}
