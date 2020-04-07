import 'package:equatable/equatable.dart';

abstract class UserLogoutEvent extends Equatable {
  UserLogoutEvent([List props = const <dynamic>[]]) : super(props);
}

class UserLogginOutEvent extends UserLogoutEvent {}
