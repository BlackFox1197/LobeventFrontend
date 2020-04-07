import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/delete_account_usecase.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  DeleteAccountUseCase usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = DeleteAccountUseCase(mockUserRepository);
  });
  final String temail = "example@ex.com";

  final User tuser = new User(
    firstname: "John",
    lastname: "Jackson",
    id: "01234",
    email: temail,
    country: "USA",
    state: "Georgia",
    postalcode: "17645",
    street: "FooBar Avenue",
    houseNumber: "4",
    phoneNumber: "+02356783564",
  );
  test(
    'should send the account inactivation request for the given user',
    () async {
      //arrange
      when(mockUserRepository.deleteAccount())
          .thenAnswer((_) async => Right(true));
      //act
      NoParams p = new NoParams();
      final result = await usecase(p);
      //assert
      expect(result, Right(true));
      verify(mockUserRepository.deleteAccount());
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
