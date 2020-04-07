import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ForgotPasswordState extends Equatable {
  ForgotPasswordState([List props = const <dynamic>[]]) : super(props);
}

class InitialForgotPasswordState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordEmptyState extends ForgotPasswordState {}

class ForgotPasswordRecoverdState extends ForgotPasswordState {
  final String email;
  ForgotPasswordRecoverdState({@required this.email}) : super([email]);
}

class ErrorForgotPasswordState extends ForgotPasswordState {
  final String message;
  ErrorForgotPasswordState({@required this.message}) : super([message]);
}
