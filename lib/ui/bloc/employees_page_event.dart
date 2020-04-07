import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeesPageEvent extends Equatable {
  EmployeesPageEvent([List props = const <dynamic>[]]) : super(props);
}

class InitializeEmployeesPageEvent extends EmployeesPageEvent {
  //initializing means getting all solar installations for the overgiven user
}

class GoToCreateNewEmployeePageEvent extends EmployeesPageEvent {}

class GoToSingleEmployeePageEvent extends EmployeesPageEvent {
  final CompanyEmployee companyEmployee;
  GoToSingleEmployeePageEvent(this.companyEmployee);
}
