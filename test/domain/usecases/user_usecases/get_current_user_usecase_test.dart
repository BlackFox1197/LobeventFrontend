import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/domain/repositories/user_repository.dart';
import 'package:auditergy_flutter/domain/usecases/user_usecases/get_current_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  GetCurrentUserUseCase usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetCurrentUserUseCase(mockUserRepository);
  });

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
  test(
    'should return the current user',
    () async {
      //arrange
      when(mockUserRepository.getCurrentUser())
          .thenAnswer((_) async => Right(tuser));
      //act
      NoParams p = new NoParams();
      final result = await usecase(p);
      //assert
      expect(result, Right(tuser));
      verify(mockUserRepository.getCurrentUser());
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
