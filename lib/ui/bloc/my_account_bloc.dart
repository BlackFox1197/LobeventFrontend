import 'dart:async';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/delete_account_usecase.dart' as da;
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart' as gcu;
import 'package:auditergy_flutter/domain/usecases/user_usecases/update_user_data_usecase.dart' as uud;
import 'package:auditergy_flutter/ui/bloc/my_account_event.dart';
import 'package:auditergy_flutter/ui/bloc/my_account_state.dart';
import 'package:auditergy_flutter/ui/utils/raw_data.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = SERVER_ERROR;

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  final da.DeleteAccountUseCase deleteAccount;
  final gcu.GetCurrentUserUseCase getCurrentUser;
  final uud.UpdateUserDataUseCase updateUserData;
  //final InputConverter inputConverter;
 
  MyAccountBloc({
    @required this.deleteAccount,
    @required this.getCurrentUser,
    @required this.updateUserData,
    //@required this.inputConverter
  }) : assert(deleteAccount != null),
       assert(getCurrentUser != null),
       assert(updateUserData != null)
      //assert(inputConverter != null)
      ;

  @override
  MyAccountState get initialState => EmptyState();


  @override
  Stream<MyAccountState> mapEventToState(
    MyAccountEvent event,
  ) async* {
    if (event is DeleteAccountEvent){
      da.NoParams np = new da.NoParams();
      yield LoadingState();
      final failureOrSuccess = await deleteAccount.call(np);   
      //yield* _eitherLoadedOrErrorState(failureOrSuccess);
       yield* failureOrSuccess.fold(
         (failure) async* {
        yield ErrorState(
            message: _mapFailureToMessageDeleteAccount(failure));
      },
       (boolean) async* {
        yield AccountDeletedState(message: ACC_DEL_SUCC);
      });
    }
    if (event is GetCurrentUserEvent){
      gcu.NoParams np = new gcu.NoParams();
      yield LoadingState();
      final failureOrSuccess = await getCurrentUser.call(np);   
      //yield* _eitherLoadedOrErrorState(failureOrSuccess);
       yield* failureOrSuccess.fold(
         (failure) async* {
        yield ErrorState(
            message: _mapFailureToMessageGetCurrentUser(failure));
      },
       (loadedUser) async* {
         if(loadedUser is CompanyAdminModel){
           yield CompanyAdminUserLoadedState(user: loadedUser);
         }else
         if(loadedUser is CompanyEmployeeModel){
           yield CompanyEmployeeUserLoadedState(user: loadedUser);
         }else
         if(loadedUser is CustomerModel){
           yield CustomerUserLoadedState(user: loadedUser);
         }else{
           yield ErrorState(message: CURR_USER_NOT_IDENTIFIED_FAILURE);
         }
      });
    }
    if (event is UpdateUserEvent){
      yield LoadingState();
      final failureOrSuccess = await updateUserData.call(new uud.Params(user: event.user)); 
      print("in the bloc of update");
      print(failureOrSuccess.runtimeType.toString());  
      //yield* _eitherLoadedOrErrorState(failureOrSuccess);
       yield* failureOrSuccess.fold(
         (failure) async* {
        yield ErrorState(
            message: _mapFailureToMessageUpdateUser(failure));
      },
       (updatedUser) async* {
         if(updatedUser is CompanyAdmin){
           yield CompanyAdminUserUpdatedState(user: updatedUser);
         }else
         if(updatedUser is CompanyEmployee){
           yield CompanyEmployeeUserUpdatedState(user: updatedUser);
         }else
         if(updatedUser is Customer){ 
           print("customer user updated state");          
           yield CustomerUserUpdatedState(user: updatedUser);
         }else{
           yield ErrorState(message: UPDATE_USER_FAILED_NOT_IDENTIFIED_FAILURE);
         }
      });
    }
          if (event is EditUserEvent){
      yield UserEditState();      
      }
    }
    //Example how to handle Event which uses Input Validation
   /* if (event is SomeInputValidatedEvent){
      final inputEither =
            inputConverter.stringToUnsignedInteger(event.NumStr);

      inputEither.fold(
        (failure) async*{
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        }
        ,
        (integer) => throw UnimplementedError(),
      );
    }*/
  }

  String _mapFailureToMessageDeleteAccount(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return ACC_DEL_FAILED_SERVER_FAILURE;
      case CacheFailure:
        return ACC_DEL_FAILED_CACHE_FAILURE;
      default:
        return CURR_USER_NOT_IDENTIFIED_FAILURE;
    }
  }
   String _mapFailureToMessageUpdateUser(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return USER_UPDATE_FAILED_SERVER_FAILURE;
      default:
        return UPDATE_USER_FAILED_NOT_IDENTIFIED_FAILURE;
    }
  }
    String _mapFailureToMessageGetCurrentUser(Failure failure){
    switch(failure.runtimeType){
      case CacheFailure:
        return CURR_USER_LOAD_FAILED_CACHE_FAILURE;
      default:
        return CURR_USER_NOT_IDENTIFIED_FAILURE;
    }
  }
