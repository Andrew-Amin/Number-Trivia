import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_conncrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  MockNumberTriviaRepository mockRepo;
  GetConcreteNumberTrivia usecase;
  setUp(() {
    mockRepo = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(repo: mockRepo);
  });

  int tNumber = 1;
  NumberTrivia tNumberTrivia =
      NumberTrivia(number: 1, text: 'test for number $tNumber');
  test(
    'should get trivia for the number from the repository',
    () async {
      //arrange
      when(mockRepo.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      //act
      final result = await usecase(number: tNumber);

      //assert
      expect(result, Right(tNumberTrivia));
      verify(mockRepo.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
