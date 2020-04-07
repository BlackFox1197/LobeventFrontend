import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  LoginUseCase usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = LoginUseCase(mockUserRepository);
  });
  final String temail = "example@ex.com";
  final String tpassword = "foobar";

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
    'should login the user',
    () async {
      //arrange
      when(mockUserRepository.login(
              email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer((_) async => Right(tuser));
      //act
      Params p = new Params(email: temail, password: tpassword);
      final result = await usecase(p);
      //assert
      expect(result, Right(tuser));
      verify(mockUserRepository.login(email: temail, password: tpassword));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
