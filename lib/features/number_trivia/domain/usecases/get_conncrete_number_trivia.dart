import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repo.dart';

class GetConcreteNumberTrivia extends Usecase {
  final NumberTriviaRepository repo;

  GetConcreteNumberTrivia({@required this.repo});

  @override
  Future<Either<Failure, NumberTrivia>> call({@required int number}) async {
    return await repo.getConcreteNumberTrivia(number);
  }
}
