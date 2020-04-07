import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  RegisterUseCase usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = RegisterUseCase(mockUserRepository);
  });
  final String temail = "example@ex.com";
  final String tpassword = "password";

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
    'should  register the user',
    () async {
      //arrange

      Params p = new Params(user: tuser, password: tpassword);
      when(mockUserRepository.register(user: p.user, password: p.password))
          .thenAnswer((_) async => Right(true));
      //act
      Params p1 = new Params(user: tuser, password: tpassword);
      final result = await usecase(p1);
      //assert
      expect(result, Right(true));
      verify(mockUserRepository.register(user: tuser, password: tpassword));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
