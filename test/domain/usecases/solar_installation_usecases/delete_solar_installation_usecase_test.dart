import 'package:auditergy_flutter/domain/repositories/solar_installation_repository.dart';
import 'package:auditergy_flutter/domain/usecases/solar_installation_usecases/delete_solar_installation_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSolarInstallationRepository extends Mock
    implements SolarInstallationRepository {}

void main() {
  DeleteSolarInstallationUseCase usecase;
  MockSolarInstallationRepository mockSolarInstallationRepository;

  setUp(() {
    mockSolarInstallationRepository = MockSolarInstallationRepository();
    usecase = DeleteSolarInstallationUseCase(mockSolarInstallationRepository);
  });
  String tSolarInstallationId = "solarInstallationId";
  test(
    'should  delete a solar installation',
    () async {
      //arrange
      Params p = new Params(solarInstallationId: tSolarInstallationId);
      when(mockSolarInstallationRepository.deleteSolarInstallation(
              solarInstallationId: p.solarInstallationId))
          .thenAnswer((_) async => Right(true));
      //act
      Params p1 = new Params(solarInstallationId: tSolarInstallationId);
      final result = await usecase(p1);
      //assert
      expect(result, Right(true));
      verify(mockSolarInstallationRepository.deleteSolarInstallation(
          solarInstallationId: tSolarInstallationId));
      verifyNoMoreInteractions(mockSolarInstallationRepository);
    },
  );
}
