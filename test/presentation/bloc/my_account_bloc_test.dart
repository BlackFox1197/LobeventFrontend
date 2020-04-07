import 'dart:math';

import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/company_employee_model.dart';
import 'package:auditergy_flutter/data/models/customer_model.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/util/input_converter.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/delete_account_usecase.dart'
    as da;
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart'
    as gcu;
import 'package:auditergy_flutter/domain/usecases/user_usecases/update_user_data_usecase.dart'
    as uud;
import 'package:auditergy_flutter/ui/bloc/bloc.dart';
import 'package:auditergy_flutter/ui/bloc/my_account_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDeleteAccountUseCase extends Mock implements da.DeleteAccountUseCase {
}

class MockGetCurrentUserUseCase extends Mock
    implements gcu.GetCurrentUserUseCase {}

class MockUpdateUserDataUseCase extends Mock
    implements uud.UpdateUserDataUseCase {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MyAccountBloc bloc;
  MockDeleteAccountUseCase mockDeleteAccountUseCase;
  MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  MockUpdateUserDataUseCase mockUpdateUserDataUseCase;
  //MockInputConverter mockInputConverter;
  setUp(() {
    mockDeleteAccountUseCase = MockDeleteAccountUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    mockUpdateUserDataUseCase = MockUpdateUserDataUseCase();
    bloc = MyAccountBloc(
        deleteAccount: mockDeleteAccountUseCase,
        getCurrentUser: mockGetCurrentUserUseCase,
        updateUserData: mockUpdateUserDataUseCase);
  });

  test('initial state should be empty', () {
    //assert
    expect(bloc.initialState, equals(EmptyState()));
  });

  group('DeleteAccount', () {
    test('should call the delete account usecase', () async {
      //arrange
      da.NoParams np = new da.NoParams();
      when(mockDeleteAccountUseCase(any)).thenAnswer((_) async => Right(true));
      //act
      bloc.dispatch(DeleteAccountEvent());
      await untilCalled(mockDeleteAccountUseCase(np));
      //assert
      verify(mockDeleteAccountUseCase(np));
    });

    test(
        'should emit[LoadingState, AccountDeletedState] when account deleted successfully',
        () async {
      //arrange
      when(mockDeleteAccountUseCase(any)).thenAnswer((_) async => Right(true));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        AccountDeletedState(message: ACC_DEL_SUCC),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(DeleteAccountEvent());
    });
    test(
        'should emit[LoadingState, ErrorState] when account could not be deleted',
        () async {
      //arrange
      when(mockDeleteAccountUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure(UNKNOWN_ERROR)));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: ACC_DEL_FAILED_SERVER_FAILURE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(DeleteAccountEvent());
    });

    test(
        'should emit[LoadingState, ErrorState] with a proper message when account could not be deleted',
        () async {
      //arrange
      when(mockDeleteAccountUseCase(any))
          .thenAnswer((_) async => Left(CacheFailure(CACHE_ERROR)));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: ACC_DEL_FAILED_CACHE_FAILURE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(DeleteAccountEvent());
    });
  });
  group('GetCurrentUser', () {
    final User tuser = new User(
      firstname: "John",
      lastname: "Jackson",
      id: "01234",
      email: "email",
      country: "USA",
      state: "Georgia",
      postalcode: "17645",
      street: "FooBar Avenue",
      houseNumber: "4",
      phoneNumber: "+02356783564",
    );
    final tCompanyAdminModel = CompanyAdminModel(
      firstname: "firstName",
      lastname: "lastName",
      id: "uid",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalCode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyName: "companyName",
      companyWebsite: "companyWebsite",
      companyEmployeesIds: ["1", "2", "3"],
    );
    final tCompanyEmployeeModel = CompanyEmployeeModel(
      firstname: "firstName",
      lastname: "lastName",
      id: "uid",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalCode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyId: "companyId",
    );
    final tCustomerModel = CustomerModel(
      firstname: "firstName",
      lastname: "lastName",
      email: "email",
      id: "id",
      country: "country",
      state: "state",
      postalcode: "postalCode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      solarServiceProviderId: "solarServiceProviderId",
    );
    test('should call the GetCurrentUserUseCase usecase', () async {
      //arrange
      gcu.NoParams np = new gcu.NoParams();
      when(mockGetCurrentUserUseCase(any))
          .thenAnswer((_) async => Right(tuser));
      //act
      bloc.dispatch(GetCurrentUserEvent());
      await untilCalled(mockGetCurrentUserUseCase(np));
      //assert
      verify(mockGetCurrentUserUseCase(np));
    });

    test(
        'should emit[LoadingState, CompanyAdminUserLoadedState] when user got successfully',
        () async {
      //arrange
      when(mockGetCurrentUserUseCase(any))
          .thenAnswer((_) async => Right(tCompanyAdminModel));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        CompanyAdminUserLoadedState(user: tCompanyAdminModel),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetCurrentUserEvent());
    });

    test(
        'should emit[LoadingState, CompanyEmployeeUserLoadedState] when user got successfully',
        () async {
      //arrange
      when(mockGetCurrentUserUseCase(any))
          .thenAnswer((_) async => Right(tCompanyEmployeeModel));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        CompanyEmployeeUserLoadedState(user: tCompanyEmployeeModel),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetCurrentUserEvent());
    });

    test(
        'should emit[LoadingState, CustomerUserLoadedState] when user got successfully',
        () async {
      //arrange
      when(mockGetCurrentUserUseCase(any))
          .thenAnswer((_) async => Right(tCustomerModel));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        CustomerUserLoadedState(user: tCustomerModel),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetCurrentUserEvent());
    });

    test('should emit[LoadingState, ErrorState] when user got successfully',
        () async {
      //arrange
      when(mockGetCurrentUserUseCase(any))
          .thenAnswer((_) async => Right(tuser));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: CURR_USER_NOT_IDENTIFIED_FAILURE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetCurrentUserEvent());
    });

    test(
        'should emit[LoadingState, ErrorState] with a proper message when user could not be loaded',
        () async {
      //arrange
      when(mockGetCurrentUserUseCase(any))
          .thenAnswer((_) async => Left(CacheFailure(CACHE_ERROR)));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: CURR_USER_LOAD_FAILED_CACHE_FAILURE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetCurrentUserEvent());
    });
  });

  group('UpdateUserData', () {
    final User tuser = new User(
      firstname: "John",
      lastname: "Jackson",
      id: "01234",
      email: "email",
      country: "USA",
      state: "Georgia",
      postalcode: "17645",
      street: "FooBar Avenue",
      houseNumber: "4",
      phoneNumber: "+02356783564",
    );
    final tCompanyAdminModel = CompanyAdminModel(
      firstname: "firstName",
      lastname: "lastName",
      id: "uid",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalCode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyName: "companyName",
      companyWebsite: "companyWebsite",
      companyEmployeesIds: ["1", "2", "3"],
    );
    final tCompanyEmployeeModel = CompanyEmployeeModel(
      firstname: "firstName",
      lastname: "lastName",
      id: "uid",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalCode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyId: "companyId",
    );
    final tCustomerModel = CustomerModel(
      firstname: "firstName",
      lastname: "lastName",
      email: "email",
      id: "id",
      country: "country",
      state: "state",
      postalcode: "postalCode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      solarServiceProviderId: "solarServiceProviderId",
    );
    test('should call the updateUserData usecase', () async {
      //arrange
      when(mockUpdateUserDataUseCase(any))
          .thenAnswer((_) async => Right(tuser));
      //act
      bloc.dispatch(UpdateUserEvent(user: tuser));
      uud.Params p = new uud.Params(user: tuser);
      await untilCalled(mockUpdateUserDataUseCase(p));
      //assert
      verify(mockUpdateUserDataUseCase(p));
    });

    test(
        'should emit[LoadingState, CompanyAdminUserUpdatedState] when user updated successfully',
        () async {
      //arrange
      when(mockUpdateUserDataUseCase(any))
          .thenAnswer((_) async => Right(tCompanyAdminModel));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        CompanyAdminUserUpdatedState(user: tCompanyAdminModel),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(UpdateUserEvent(user: tCompanyAdminModel));
    });

    test(
        'should emit[LoadingState, CompanyEmployeeUserUpdatedState] when user updated successfully',
        () async {
      //arrange
      when(mockUpdateUserDataUseCase(any))
          .thenAnswer((_) async => Right(tCompanyEmployeeModel));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        CompanyEmployeeUserUpdatedState(user: tCompanyEmployeeModel),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(UpdateUserEvent(user: tCompanyEmployeeModel));
    });

    test(
        'should emit[LoadingState, CustomerUserUpdatedState] when user updated successfully',
        () async {
      //arrange
      when(mockUpdateUserDataUseCase(any))
          .thenAnswer((_) async => Right(tCustomerModel));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        CustomerUserUpdatedState(user: tCustomerModel),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(UpdateUserEvent(user: tCustomerModel));
    });

    test(
        'should emit[LoadingState, ErrorState] when user could not be identified from the struct',
        () async {
      //arrange
      when(mockUpdateUserDataUseCase(any))
          .thenAnswer((_) async => Right(tuser));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: UPDATE_USER_FAILED_NOT_IDENTIFIED_FAILURE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(UpdateUserEvent(user: tuser));
    });

    test(
        'should emit[LoadingState, ErrorState] with a proper message when user could not be loaded',
        () async {
      //arrange
      when(mockUpdateUserDataUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure(SERVER_ERROR)));
      //assert later
      final expected = [
        EmptyState(),
        LoadingState(),
        ErrorState(message: USER_UPDATE_FAILED_SERVER_FAILURE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(UpdateUserEvent(user: tCompanyAdminModel));
    });
  });
}
