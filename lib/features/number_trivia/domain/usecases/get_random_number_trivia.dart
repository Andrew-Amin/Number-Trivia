import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repo.dart';

class GetRandomNumberTrivia extends Usecase {
  final NumberTriviaRepository repo;

  GetRandomNumberTrivia({this.repo});
  @override
  Future<Either<Failure, NumberTrivia>> call() async {
    return await repo.getRandomNumberTrivia();
  }
}
