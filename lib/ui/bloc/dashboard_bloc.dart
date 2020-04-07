import 'dart:async';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/get_solar_installations_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:auditergy_flutter/ui/bloc/dashboard_event.dart';
import 'package:auditergy_flutter/ui/bloc/dashboard_state.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSolarInstallationsUseCase getSolarInstallationsUseCase;

  DashboardBloc(
      {@required this.getCurrentUserUseCase,
      @required this.getSolarInstallationsUseCase})
      : assert(getCurrentUserUseCase != null),
        assert(getSolarInstallationsUseCase != null);

  @override
  DashboardState get initialState => DashboardUninitializedState();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is InitializeDashboardEvent) {
      // loadingState while fetching data
      yield DashboardLoadingState();
      final failureOrcurrentUser = await getCurrentUserUseCase.call(NoParams());
      yield* failureOrcurrentUser.fold((failure) async* {
        yield DashboardErrorState(errorMessage: _mapFailureToMessage(failure));
      }, (currentUser) async* {
        final failureOrSolarInstallationList =
            await getSolarInstallationsUseCase.call(Params(user: currentUser));
        yield* failureOrSolarInstallationList.fold((failure) async* {
          yield DashboardErrorState(
              errorMessage: _mapFailureToMessage(failure));
        }, (solarInstallationList) async* {
          yield DashboardInitializedState(
              solarInstallationList: solarInstallationList);
        });
      });
      //
    } else if (event is GoToCreateSolarInstallationPageEvent) {
      //switch state to CreateInstallationPage
      yield CreateSolarInstallationPageState();
      //
    } else if (event is GoToSingleSolarInstallationPageEvent) {
      // loadingState while fetching data
      yield SingleInstallationPageState(
          solarInstallation: event.solarInstallation);
    }
    //
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
