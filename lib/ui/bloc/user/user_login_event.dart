import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class AbstractUserLoginEvent extends Equatable {
  AbstractUserLoginEvent([List props = const <dynamic>[]]) : super(props);
}

class UserLoginEvent extends AbstractUserLoginEvent {
  final String email;
  final String password;
  UserLoginEvent(this.email, this.password) : super([email, password]);
}

class UserRegisterEvent extends AbstractUserLoginEvent {
  // final String firstName;
  // final String lastName;
  // final String email;
  // final String country;
  // final String state;
  // final String postalCode;
  // final String street;
  // final String houseNumber;
  // final String phoneNumber;
  final User user;
  final String password;

  UserRegisterEvent(this.user, this.password) : super([user, password]);
}

class LoginShowUiEvent extends AbstractUserLoginEvent {}

class ShowRegisterCompanyAdminUiEvent extends AbstractUserLoginEvent {}

class ShowRegisterCustomerUiEvent extends AbstractUserLoginEvent {}
