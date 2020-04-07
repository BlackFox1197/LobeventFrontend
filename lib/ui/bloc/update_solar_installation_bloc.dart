import 'dart:async';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/create_solar_installation_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';

class UpdateSolarInstallationBloc
    extends Bloc<UpdateSolarInstallationEvent, UpdateSolarInstallationState> {
  //TODO: add the corresponding usecase here
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CreateSolarInstallationUseCase createSolarInstallationUseCase;

  UpdateSolarInstallationBloc(
      {@required this.getCurrentUserUseCase,
      @required this.createSolarInstallationUseCase})
      : assert(getCurrentUserUseCase != null),
        assert(createSolarInstallationUseCase != null);

  @override
  UpdateSolarInstallationState get initialState =>
      ShowImmutableSolarInstallationDataState();

  @override
  Stream<UpdateSolarInstallationState> mapEventToState(
    UpdateSolarInstallationEvent event,
  ) async* {
    if (event is ShowImmutableSolarInstallationDataEvent) {
      // loadingState while fetching data
      yield UpdateSolarInstallationLoadingState();
/*       final failureOrcurrentUser = await getCurrentUserUseCase.call(NoParams());
      yield* failureOrcurrentUser.fold((failure) async* {
        yield CreateSolarInstallationErrorState(
            errorMessage: _mapFailureToMessage(failure));
      }, (currentUser) async* {
        yield CreateSolarInstallationInitializedState(currentUser: currentUser);
      }); */
      //
    } else if (event is SubmitUpdateSolarInstallationEvent) {
      // loadingState while fetching data
      yield UpdateSolarInstallationLoadingState();
/*       final failureOrBoolean = await createSolarInstallationUseCase
          .call(Params(solarInstallation: event.solarInstallation));
      yield* failureOrBoolean.fold((failure) async* {
        yield CreateSolarInstallationErrorState(
            errorMessage: _mapFailureToMessage(failure));
      }, (boolean) async* {
        yield CreateSolarInstallationSuccessState();
      }); */
    }
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
