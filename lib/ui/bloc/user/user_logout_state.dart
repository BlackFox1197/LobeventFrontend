import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserLogoutState extends Equatable {
  UserLogoutState([List props = const <dynamic>[]]) : super(props);
}

class InitialUserLogoutState extends UserLogoutState {}

class UserLogoutLoadingState extends UserLogoutState {}

class UserLoggedOutState extends UserLogoutState {}

class ErrorLogoutState extends UserLogoutState {
  final String message;
  ErrorLogoutState({@required this.message}) : super([message]);
}
