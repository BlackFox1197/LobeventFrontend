import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MyAccountState extends Equatable {
  MyAccountState([List props = const <dynamic>[]]) : super(props);
}
class AccountDeletedState extends MyAccountState {
  final String message;
  AccountDeletedState({@required this.message}):super([message]);
}

class InitialState extends MyAccountState {
  InitialState();
}

class EmptyState extends MyAccountState {
  final String message = "";
  EmptyState();  
}
class ErrorState extends MyAccountState {
  final String message;
  ErrorState({@required this.message}):super([message]);  
}
class LoadingState extends MyAccountState {
  LoadingState();  
}
class CompanyAdminUserLoadedState extends MyAccountState {
  final User user;
  CompanyAdminUserLoadedState({@required this.user}):super([user]);  
}
class CompanyEmployeeUserLoadedState extends MyAccountState {
  final User user;
  CompanyEmployeeUserLoadedState({@required this.user}):super([user]);  
}
class CustomerUserLoadedState extends MyAccountState {
  final User user;
  CustomerUserLoadedState({@required this.user}):super([user]);  
}
class UserEditState extends MyAccountState {

  UserEditState();  
}
class CompanyAdminUserUpdatedState extends MyAccountState {
  final User user;
  CompanyAdminUserUpdatedState({@required this.user}):super([user]);  
}
class CompanyEmployeeUserUpdatedState extends MyAccountState {
  final User user;
  CompanyEmployeeUserUpdatedState({@required this.user}):super([user]);  
}
class CustomerUserUpdatedState extends MyAccountState {
  final User user;
  CustomerUserUpdatedState({@required this.user}):super([user]);  
}
class UserUpdateFailedState extends MyAccountState {
  final String message;
  UserUpdateFailedState({@required this.message}):super([message]);  
}