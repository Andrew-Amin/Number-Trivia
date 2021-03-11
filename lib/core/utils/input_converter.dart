import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String number) {
    try {
      final convertedNumber = int.parse(number);
      if (convertedNumber > 0) {
        return Right(convertedNumber);
      } else {
        throw FormatException();
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
