import 'dart:async';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/delete_solar_installation_usecase.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';

class DeleteSolarInstallationBloc
    extends Bloc<DeleteSolarInstallationEvent, DeleteSolarInstallationState> {
  final DeleteSolarInstallationUseCase deleteSolarInstallationUseCase;

  DeleteSolarInstallationBloc({@required this.deleteSolarInstallationUseCase})
      : assert(deleteSolarInstallationUseCase != null);

  @override
  DeleteSolarInstallationState get initialState =>
      DisplayExisingSolarInstallationState();

  @override
  Stream<DeleteSolarInstallationState> mapEventToState(
    DeleteSolarInstallationEvent event,
  ) async* {
    if (event is InitializeSolarInstallationFormEvent) {
      // loadingState while changing states
      yield DisplayExisingSolarInstallationState();
      //
    } else if (event is SubmitDeleteSolarInstallationEvent) {
      // loadingState while fetching data
      yield DeleteSolarInstallationLoadingState();
      final failureOrBoolean = await deleteSolarInstallationUseCase
          .call(Params(solarInstallationId: event.solarInstallationId));
      yield* failureOrBoolean.fold((failure) async* {
        yield DeleteSolarInstallationErrorState(
            errorMessage: _mapFailureToMessage(failure));
      }, (boolean) async* {
        yield DeleteSolarInstallationSuccessState();
      });
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
