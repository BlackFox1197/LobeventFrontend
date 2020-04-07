import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/login_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/logout_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  LogoutUseCase usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = LogoutUseCase(mockUserRepository);
  });
  test(
    'should logout the user',
    () async {
      //arrange
      when(mockUserRepository.logout()).thenAnswer((_) async => Right(true));
      //act
      NoParams p = new NoParams();
      final result = await usecase(p);
      //assert
      expect(result, Right(true));
      verify(mockUserRepository.logout());
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
