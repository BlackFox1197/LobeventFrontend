import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/update_user_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  UpdateUserDataUseCase usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UpdateUserDataUseCase(mockUserRepository);
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
    'should update the user',
    () async {
      //arrange

      Params p = new Params(user: tuser);
      when(mockUserRepository.updateUserData(user: p.user))
          .thenAnswer((_) async => Right(tuser));
      //act
      Params p1 = new Params(user: tuser);
      final result = await usecase(p1);
      //assert
      expect(result, Right(tuser));
      verify(mockUserRepository.updateUserData(user: tuser));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
