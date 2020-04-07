import 'dart:async';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/logout_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import './user_bloc.dart';

class UserLogoutBloc extends Bloc<UserLogoutEvent, UserLogoutState> {
  final LogoutUseCase logoutUseCase;

  UserLogoutBloc({@required LogoutUseCase logout})
      : assert(logout != null),
        logoutUseCase = logout;

  @override
  UserLogoutState get initialState => InitialUserLogoutState();

  @override
  Stream<UserLogoutState> mapEventToState(
    UserLogoutEvent event,
  ) async* {
    if (event is UserLogginOutEvent) {
      yield UserLogoutLoadingState();
      final failureOrSuccess = await logoutUseCase(NoParams());
      yield* _eitherSuccessOrErrorState(failureOrSuccess);
    }
  }

  Stream<UserLogoutState> _eitherSuccessOrErrorState(
    Either<Failure, bool> failureOrSuccess,
  ) async* {
    yield failureOrSuccess.fold(
        (failure) => ErrorLogoutState(message: _mapFailureToMessage(failure)),
        (success) => UserLoggedOutState());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Logout failed. " + SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return "Logout failed. " + CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
