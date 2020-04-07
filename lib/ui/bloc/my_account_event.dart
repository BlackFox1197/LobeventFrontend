import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MyAccountEvent extends Equatable {
  MyAccountEvent([List props = const <dynamic>[]]) : super(props);
}

class DeleteAccountEvent extends MyAccountEvent {
  DeleteAccountEvent();
}

class GetCurrentUserEvent extends MyAccountEvent {
  GetCurrentUserEvent();
}

class UpdateUserEvent extends MyAccountEvent {
  final User user;
  UpdateUserEvent({@required this.user})
      : super([user]);
}

class EditUserEvent extends MyAccountEvent {
  EditUserEvent();
}