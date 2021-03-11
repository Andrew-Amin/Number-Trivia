import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/errors/failures.dart';
import 'package:number_trivia/core/utils/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });
  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () {
        // arrange
        String tStringNumber = '123';
        // act
        final result = inputConverter.stringToUnsignedInteger(tStringNumber);
        // assert
        expect(result, Right(123));
      },
    );

    test(
      'should return a InvalidInputFailur when the string is not integer or negative',
      () {
        // arrange
        String str1 = 'abs';
        String str2 = '-123';
        // act
        final resultFromStr1 = inputConverter.stringToUnsignedInteger(str1);
        final resultFromStr2 = inputConverter.stringToUnsignedInteger(str2);
        // assert
        expect(resultFromStr1, Left(InvalidInputFailure()));
        expect(resultFromStr2, Left(InvalidInputFailure()));
      },
    );
  });
}
