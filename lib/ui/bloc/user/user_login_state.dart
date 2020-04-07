import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserLoginState extends Equatable {
  UserLoginState([List props = const <dynamic>[]]) : super(props);
}

// Class for loginCard
abstract class AbstractLoginState extends UserLoginState {
  AbstractLoginState([List props = const <dynamic>[]]) : super(props);
}

// Class for registerCard
abstract class AbstractRegisterState extends UserLoginState {
  AbstractRegisterState([List props = const <dynamic>[]]) : super(props);
}

class InitialUserLoginState extends AbstractLoginState {}

class UserLoginLoadingState extends AbstractLoginState {}

class UserLoggedInState extends AbstractLoginState {
  final User user;
  UserLoggedInState({@required this.user}) : super([user]);
}

class RegisterCompanyAdminState extends AbstractRegisterState {}

class RegisterCustomerState extends AbstractRegisterState {}

class UserRegisterLoadingState extends AbstractRegisterState {}

class UserRegisteredState extends AbstractRegisterState {
  final User user;
  UserRegisteredState({@required this.user}) : super([user]);
}

class LoginErrorState extends UserLoginState {
  final String message;
  LoginErrorState({@required this.message}) : super([message]);
}
