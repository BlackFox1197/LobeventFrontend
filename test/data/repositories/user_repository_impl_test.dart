import 'package:auditergy_flutter/data/datasources/local_data_source/user_local_data_source.dart';
import 'package:auditergy_flutter/data/datasources/remote_data_source/user_remote_data_source.dart';
import 'package:auditergy_flutter/data/models/company_admin_model.dart';
import 'package:auditergy_flutter/data/models/user_model.dart';
import 'package:auditergy_flutter/data/repositories/user_repository_impl.dart';
import 'package:auditergy_flutter/domain/core/constants/constants.dart';
import 'package:auditergy_flutter/domain/core/error/exceptions.dart';
import 'package:auditergy_flutter/domain/core/error/failures.dart';
import 'package:auditergy_flutter/domain/core/network/network_info.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  UserRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('login', () {
    final String temail = "example@ex.com";
    final String tpassword = "foobar";
    final UserModel tUserModel = new UserModel(
      firstname: "John",
      lastname: "Jackson",
      id: "01234",
      email: "example@ex.com",
      country: "USA",
      state: "Georgia",
      postalcode: "17645",
      street: "FooBar Avenue",
      houseNumber: "4",
      phoneNumber: "+02356783564",
    );
    final User tUser = tUserModel;
    String tAccessToken = "token";

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.login(email: temail, password: tpassword);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.login(temail, tpassword))
            .thenAnswer((_) async => [tUser, tAccessToken]);
        // act
        final result =
            await repository.login(email: temail, password: tpassword);
        // assert
        verify(mockRemoteDataSource.login(temail, tpassword));
        expect(result, equals(Right(tUser)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.login(temail, tpassword))
            .thenAnswer((_) async => [tUser, tAccessToken]);
        // act
        await repository.login(email: temail, password: tpassword);
        // assert
        verify(mockRemoteDataSource.login(temail, tpassword));
        verify(mockLocalDataSource.cacheCurrentUser(tUser));
        verify(mockLocalDataSource.cacheAccessToken(tAccessToken));
      });

      test(
          'should return null failure when the call to remote data source is successfull, but returned object is null(default case)',
          () async {
        // arrange
        when(mockRemoteDataSource.login(temail, tpassword))
            .thenAnswer((_) async => null);
        // act
        final result =
            await repository.login(email: temail, password: tpassword);
        // assert
        verify(mockRemoteDataSource.login(temail, tpassword));
        expect(result, equals(Left(NullFailure(NULL_INSTANCE_USER))));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessfull',
          () async {
        // arrange
        when(mockRemoteDataSource.login(temail, tpassword))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        // act
        final result =
            await repository.login(email: temail, password: tpassword);
        // assert
        verify(mockRemoteDataSource.login(temail, tpassword));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure(UNKNOWN_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return Failure when there is no network', () async {
        // arrange
        // act
        final result =
            await repository.login(email: temail, password: tpassword);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure(NETWORK_ERROR))));
      });
    });
  }); //end of top group
  group('register', () {
    final UserModel tUserModel = new UserModel(
      firstname: "John",
      lastname: "Jackson",
      id: "01234",
      email: "example@ex.com",
      country: "USA",
      state: "Georgia",
      postalcode: "17645",
      street: "FooBar Avenue",
      houseNumber: "4",
      phoneNumber: "+02356783564",
    );
    final User tUser = tUserModel;
    final String tpassword = "password";

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.register(user: tUser, password: tpassword);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.register(tUser, tpassword))
            .thenAnswer((_) async => true);
        // act
        final result =
            await repository.register(user: tUser, password: tpassword);
        // assert
        verify(mockRemoteDataSource.register(tUser, tpassword));
        expect(result, equals(Right(true)));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.register(tUser, tpassword))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        // act
        final result =
            await repository.register(user: tUser, password: tpassword);
        // assert
        verify(mockRemoteDataSource.register(tUser, tpassword));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure(UNKNOWN_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return Failure when there is no network', () async {
        // arrange
        // act
        final result =
            await repository.register(user: tUser, password: tpassword);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure(NETWORK_ERROR))));
      });
    });
  }); //end of top group
  group('forgotPassword', () {
    final String tEmail = "email@test.com";

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.forgotPassword(email: tEmail);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.forgotPassword(tEmail))
            .thenAnswer((_) async => true);
        // act
        final result = await repository.forgotPassword(email: tEmail);
        // assert
        verify(mockRemoteDataSource.forgotPassword(tEmail));
        expect(result, equals(Right(true)));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.forgotPassword(tEmail))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        // act
        final result = await repository.forgotPassword(email: tEmail);
        // assert
        verify(mockRemoteDataSource.forgotPassword(tEmail));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure(UNKNOWN_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return Failure when there is no network', () async {
        // arrange
        // act
        final result = await repository.forgotPassword(email: tEmail);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure(NETWORK_ERROR))));
      });
    });
  }); //end of top group
  group('updateUserData', () {
    final String temail = "example@ex.com";
    final String tpassword = "foobar";
    final tCompanyAdminModel = CompanyAdminModel(
      firstname: "firstname",
      lastname: "lastname",
      id: "id",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalcode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyName: "companyName",
      companyWebsite: "companyWebsite",
      companyEmployeesIds: ["1", "2", "3"],
    );
    final User tCompanyAdmin = tCompanyAdminModel;
    String tAccessToken = "token";

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.updateUserData(user: tCompanyAdmin);
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return true when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.updateUserData([tCompanyAdmin, tAccessToken]))
            .thenAnswer((_) async => tCompanyAdmin);
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => tAccessToken);
        // act
        final result = await repository.updateUserData(user: tCompanyAdmin);
        // assert
        verify(
            mockRemoteDataSource.updateUserData([tCompanyAdmin, tAccessToken]));
        expect(result, equals(Right(tCompanyAdmin)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessfull',
          () async {
        // arrange
        when(mockRemoteDataSource.updateUserData([tCompanyAdmin, tAccessToken]))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        when(mockLocalDataSource.getAccessToken())
            .thenAnswer((_) async => tAccessToken);
        // act
        final result = await repository.updateUserData(user: tCompanyAdmin);
        // assert
        verify(
            mockRemoteDataSource.updateUserData([tCompanyAdmin, tAccessToken]));
        expect(result, equals(Left(ServerFailure(UNKNOWN_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return Failure when there is no network', () async {
        // arrange

        // act
        final result = await repository.updateUserData(user: tCompanyAdmin);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure(NETWORK_ERROR))));
      });
    });
  }); //end of top group
  group('getCurrentUser', () {
    final tCompanyAdminModel = CompanyAdminModel(
      firstname: "firstname",
      lastname: "lastname",
      id: "id",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalcode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyName: "companyName",
      companyWebsite: "companyWebsite",
      companyEmployeesIds: ["1", "2", "3"],
    );
    final User tCompanyAdmin = tCompanyAdminModel;

    test('should return User when the call to local data source is successful',
        () async {
      // arrange
      when(mockLocalDataSource.getCurrentUser())
          .thenAnswer((_) async => tCompanyAdmin);
      // act
      final result = await repository.getCurrentUser();
      // assert
      verify(mockLocalDataSource.getCurrentUser());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Right(tCompanyAdmin)));
    });

    test(
        'should return cache failure when the call to local data source is unsuccessfull',
        () async {
      // arrange
      when(mockLocalDataSource.getCurrentUser()).thenThrow(CacheException());
      // act
      final result = await repository.getCurrentUser();
      // assert
      verify(mockLocalDataSource.getCurrentUser());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(CacheFailure(CACHE_ERROR))));
    });
  }); //end of top group
  group('logout', () {
    test(
        'should return true when the logout call to local data source is successful',
        () async {
      // arrange
      when(mockLocalDataSource.logout()).thenAnswer((_) async => true);
      // act
      final result = await repository.logout();
      // assert
      verify(mockLocalDataSource.logout());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Right(true)));
    });

    test(
        'should return cache failure when the logout call to local data source is unsuccessfull',
        () async {
      // arrange
      when(mockLocalDataSource.logout()).thenThrow(CacheException());
      // act
      final result = await repository.logout();
      // assert
      verify(mockLocalDataSource.logout());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(CacheFailure(CACHE_ERROR))));
    });
  }); //end of top group
  group('deleteAccount', () {
    final UserModel tUserModel = new UserModel(
      firstname: "John",
      lastname: "Jackson",
      id: "01234",
      email: "example@ex.com",
      country: "USA",
      state: "Georgia",
      postalcode: "17645",
      street: "FooBar Avenue",
      houseNumber: "4",
      phoneNumber: "+02356783564",
    );
    final User tUser = tUserModel;

    group('Network Status Check', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.deleteAccount();
        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });

    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return true when the call to remote data source is successfull and user could be inactivated',
          () async {
        // arrange
        when(mockLocalDataSource.getCurrentUser())
            .thenAnswer((_) async => tUser);
        when(mockRemoteDataSource.deleteAccount(tUser))
            .thenAnswer((_) async => true);
        // act
        final result = await repository.deleteAccount();
        // assert
        verify(mockRemoteDataSource.deleteAccount(tUser));
        expect(result, equals(Right(true)));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockLocalDataSource.getCurrentUser())
            .thenAnswer((_) async => tUser);
        when(mockRemoteDataSource.deleteAccount(tUser))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        // act
        final result = await repository.deleteAccount();
        // assert
        verify(mockRemoteDataSource.deleteAccount(tUser));
        expect(result, equals(Left(ServerFailure(UNKNOWN_ERROR))));
      });
      test(
          'should return cache failure when the call to local data source is unsuccessful',
          () async {
        // arrange
        when(mockLocalDataSource.getCurrentUser()).thenThrow(CacheException());
        when(mockRemoteDataSource.deleteAccount(tUser))
            .thenThrow(ServerException(UNKNOWN_ERROR));
        // act
        final result = await repository.deleteAccount();
        // assert
        expect(result, equals(Left(CacheFailure(CACHE_ERROR))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return Failure when there is no network', () async {
        // arrange
        // act
        final result = await repository.deleteAccount();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure(NETWORK_ERROR))));
      });
    });
  }); //end of top group
  group('isAuthenticated', () {
    final tCompanyAdminModel = CompanyAdminModel(
      firstname: "firstname",
      lastname: "lastname",
      id: "id",
      email: "email",
      country: "country",
      state: "state",
      postalcode: "postalcode",
      street: "street",
      houseNumber: "houseNumber",
      phoneNumber: "phoneNumber",
      companyName: "companyName",
      companyWebsite: "companyWebsite",
      companyEmployeesIds: ["1", "2", "3"],
    );
    final User tCompanyAdmin = tCompanyAdminModel;
    test('should return true when the call to local data source is successful',
        () async {
      // arrange
      when(mockLocalDataSource.getCurrentUser())
          .thenAnswer((_) async => tCompanyAdmin);
      // act
      final result = await repository.isAuthenticated();
      // assert
      verify(mockLocalDataSource.getCurrentUser());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(true));
    });

    test(
        'should return cache failure when the logout call to local data source is unsuccessfull',
        () async {
      // arrange
      when(mockLocalDataSource.getCurrentUser()).thenThrow(CacheException());
      // act
      final result = await repository.isAuthenticated();
      // assert
      verify(mockLocalDataSource.getCurrentUser());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(false));
    });
  }); //end of top group
}
