import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/solar_installation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EmployeesPageState extends Equatable {
  EmployeesPageState([List props = const <dynamic>[]]) : super(props);
}

//uninitialized
class EmployeesPageUninitializedState extends EmployeesPageState {}

//loading
class EmployeesPageLoadingState extends EmployeesPageState {}

//error
class EmployeesPageErrorState extends EmployeesPageState {
  final String errorMessage;

  EmployeesPageErrorState({@required this.errorMessage})
      : super([errorMessage]);
}

//initialized
class EmployeesPageInitializedState extends EmployeesPageState {
  final List<CompanyEmployee> companyEmployeeList;

  EmployeesPageInitializedState({@required this.companyEmployeeList});

  @override
  List<Object> get props => [];
}

//create new employee
class CreateNewEmployeePageState extends EmployeesPageState {}

//view single employee page
class SingleEmployeePageState extends EmployeesPageState {
  final CompanyEmployee companyEmployee;

  SingleEmployeePageState({@required this.companyEmployee});

  @override
  List<Object> get props => [];
}
