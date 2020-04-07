import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/forgot_password_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  ForgotPasswordUseCase usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = ForgotPasswordUseCase(mockUserRepository);
  });

  String temail = "email@email.com";
  test(
    'should return true when request was successfull',
    () async {
      //arrange
      when(mockUserRepository.forgotPassword(email: temail))
          .thenAnswer((_) async => Right(true));
      //act
      Params p = new Params(email: temail);
      final result = await usecase(p);
      //assert
      expect(result, Right(true));
      verify(mockUserRepository.forgotPassword(email: temail));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
