import 'dart:async';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/get_solar_installations_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:auditergy_flutter/ui/bloc/dashboard_event.dart';
import 'package:auditergy_flutter/ui/bloc/dashboard_state.dart';
import 'package:auditergy_flutter/ui/bloc/employees_page_event.dart';
import 'package:auditergy_flutter/ui/bloc/employees_page_state.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';

class EmployeesPageBloc extends Bloc<EmployeesPageEvent, EmployeesPageState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  //TODO: getEmployees
  //final GetSolarInstallationsUseCase getSolarInstallationsUseCase;

  EmployeesPageBloc({
    @required this.getCurrentUserUseCase,
    //@required this.getSolarInstallationsUseCase
  }) : assert(getCurrentUserUseCase != null);
  //assert(getSolarInstallationsUseCase != null)

  @override
  EmployeesPageState get initialState => EmployeesPageUninitializedState();

  @override
  Stream<EmployeesPageState> mapEventToState(
    EmployeesPageEvent event,
  ) async* {
    if (event is InitializeEmployeesPageEvent) {
      // loadingState while fetching data
      yield EmployeesPageLoadingState();
      final failureOrcurrentUser = await getCurrentUserUseCase.call(NoParams());
      yield* failureOrcurrentUser.fold((failure) async* {
        yield EmployeesPageErrorState(
            errorMessage: _mapFailureToMessage(failure));
      }, (currentUser) async* {
        //TODO: getEmployees for company admin
/*         final failureOrCompanyEmployeeList =
            await getSolarInstallationsUseCase.call(Params(user: currentUser));
        yield* failureOrCompanyEmployeeList.fold((failure) async* {
          yield EmployeesPageErrorState(
              errorMessage: _mapFailureToMessage(failure));
        }, (companyEmployeeList) async* {
          yield EmployeesPageInitializedState(
              companyEmployeeList: companyEmployeeList);
        }); */
      });
      //
    } else if (event is GoToCreateNewEmployeePageEvent) {
      //switch state to CreateInstallationPage
      yield CreateNewEmployeePageState();
      //
    } else if (event is GoToSingleEmployeePageEvent) {
      // loadingState while fetching data
      yield SingleEmployeePageState(companyEmployee: event.companyEmployee);
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
