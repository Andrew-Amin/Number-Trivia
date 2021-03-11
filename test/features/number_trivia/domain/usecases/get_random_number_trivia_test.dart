import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  MockNumberTriviaRepository mockRepo;
  GetRandomNumberTrivia usecase;
  setUp(() {
    mockRepo = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(repo: mockRepo);
  });

  NumberTrivia tNumberTrivia =
      NumberTrivia(number: 1, text: 'test for random number 1');
  test(
    'should get trivia for random number from the repository',
    () async {
      //arrange
      when(mockRepo.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));

      //act
      final result = await usecase();

      //assert
      expect(result, Right(tNumberTrivia));
      verify(mockRepo.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
