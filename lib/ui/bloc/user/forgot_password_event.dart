import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  ForgotPasswordEvent([List props = const <dynamic>[]]) : super(props);
}

class ForgotPasswordRecoverEvent extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordRecoverEvent(this.email) : super([email]);
}

class ForgotPasswordShowUiEvent extends ForgotPasswordEvent {}

class ForgotPasswordCloseUiEvent extends ForgotPasswordEvent {}
