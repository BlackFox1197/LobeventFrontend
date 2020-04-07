import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SidebarState extends Equatable {
  SidebarState([List props = const <dynamic>[]]) : super(props);
}

class SidebarInitializedState extends SidebarState {
  final User currentUser;

  SidebarInitializedState({@required this.currentUser});

  @override
  List<Object> get props => [];
}

class SidebarUninitializedState extends SidebarState {}

class SidebarLoadingState extends SidebarState {}

class SidebarErrorState extends SidebarState {
  final String errorMessage;

  SidebarErrorState({@required this.errorMessage}) : super([errorMessage]);
}
