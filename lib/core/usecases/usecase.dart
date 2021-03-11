import 'package:dartz/dartz.dart';

import '../../features/number_trivia/domain/entities/number_trivia.dart';
import '../errors/failures.dart';

// use this shape if we want to pass parameters to the abstract class
// abstract class Usecase<T,Params>{
//   Future<Either<Failure , NumberTrivia>> call(Params parameter);
// }
// class NoParams extends Equatable{
//   @override
//   List<Object> get props => [];
// }

abstract class Usecase<T> {
  Future<Either<Failure, NumberTrivia>> call();
}
