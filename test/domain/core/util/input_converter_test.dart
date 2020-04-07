import 'package:auditergy_flutter/domain/core/util/input_converter.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () async {
      //arrange
      final str = '123';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Right(123));
    });
    test(
        'should return a failure when the string does not represent an unsigned integer',
        () async {
      //arrange
      final str = 'abc';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test(
        'should return a failure when the string does not represent an unsigned integer',
        () async {
      //arrange
      final str = '-123';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });

/*   group(
    'stringsToUser',
    () {
      test(
          'should return a User when the strings does represent the correct strings',
          () async {
        //arrange
        final firstname = 'Max';
        final lastname = 'Mustermann';
        final id = '123';
        final email = 'max.mustermann@gmail.de';
        final country = 'Germany';
        final state = 'Thuringia';
        final postalcode = '12345';
        final street = 'Hauptstrasse';
        final houseNumber = '1';
        final phoneNumber = '1234 56789';
        //act
        final result = inputConverter.stringsToUser(
            firstname,
            lastname,
            id,
            email,
            country,
            state,
            postalcode,
            street,
            houseNumber,
            phoneNumber);
        //assert
        expect(
            result,
            Right(new User(
                firstname: 'Max',
                lastname: 'Mustermann',
                id: '123',
                email: 'max.mustermann@gmail.de',
                country: 'Germany',
                state: 'Thuringia',
                postalcode: '12345',
                street: 'Hauptstrasse',
                houseNumber: '1',
                phoneNumber: '1234 56789')));
      });
    },
  ); */
}
