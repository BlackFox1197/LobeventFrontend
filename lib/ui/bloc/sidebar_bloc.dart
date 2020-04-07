import 'dart:async';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
//import 'package:auditergy_flutter/domain/usecases/user_usecases/logout_usecase.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  //final LogoutUseCase logoutUseCase;

  SidebarBloc({
    @required this.getCurrentUserUseCase,
    //@required this.logoutUseCase
  }) : assert(getCurrentUserUseCase != null);
  // assert(logoutUseCase != null);

  @override
  SidebarState get initialState => SidebarUninitializedState();

  @override
  Stream<SidebarState> mapEventToState(
    SidebarEvent event,
  ) async* {
    if (event is InitializeSidebarEvent) {
      // loadingState while fetching data
      yield SidebarLoadingState();
      final failureOrcurrentUser = await getCurrentUserUseCase.call(NoParams());
      yield* failureOrcurrentUser.fold((failure) async* {
        yield SidebarErrorState(errorMessage: _mapFailureToMessage(failure));
      }, (currentUser) async* {
        yield SidebarInitializedState(currentUser: currentUser);
      });
      //
    }
    /*   else if (event is SubmitSolarInstallationFormEvent) {
      // loadingState while fetching data
      yield CreateSolarInstallationLoadingState();
      final failureOrBoolean = await createSolarInstallationUseCase
          .call(Params(solarInstallation: event.solarInstallation));
      yield* failureOrBoolean.fold((failure) async* {
        yield CreateSolarInstallationErrorState(
            errorMessage: _mapFailureToMessage(failure));
      }, (boolean) async* {
        yield CreateSolarInstallationSuccessState();
      });
    } */
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_ERROR;
      case CacheFailure:
        return CACHE_ERROR;
      default:
        return UNKNOWN_ERROR;
    }
  }
}
