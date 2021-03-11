import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/failures.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_conncrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc tBloc;
  MockGetConcreteNumberTrivia mockConcreteNumberTriviaUsecase;
  MockGetRandomNumberTrivia mockRandomNumberTriviaUsecase;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockConcreteNumberTriviaUsecase = MockGetConcreteNumberTrivia();
    mockRandomNumberTriviaUsecase = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    tBloc = NumberTriviaBloc(
      concrete: mockConcreteNumberTriviaUsecase,
      random: mockRandomNumberTriviaUsecase,
      inputConverter: mockInputConverter,
    );
  });

  tearDown(() {
    tBloc.close();
  });

  test('initialState should be Empty', () {
    expect(tBloc.state, Empty());
  });

  group(
    'GetTriviaForConcreteNumber',
    () {
      final tNumberString = '1';
      final tNumberParsed = int.parse(tNumberString);
      final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

      void setUpMockInputConverterSuccess() =>
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Right(tNumberParsed));

      test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          // act
          tBloc.add(GetTriviaForConcreteNumber(tNumberString));
          completion(mockInputConverter.stringToUnsignedInteger(tNumberString));
          // assert
          verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
        },
      );

      test(
        'should emit [Error] when the input is invalid',
        () async {
          // arrange
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(InvalidInputFailure()));
          // assert later
          // final expected = [
          //   // The initial state is always emitted first
          //   Empty(),
          //   Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE),
          // ];
          expectLater(
              tBloc, emits(Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE)));
          // act
          tBloc.add(GetTriviaForConcreteNumber(tNumberString));
        },
      );
      test(
        'should emit [Loading, Loaded] when data is gotten successfully',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          when(mockConcreteNumberTriviaUsecase(number: tNumberParsed))
              .thenAnswer((_) async => Right(tNumberTrivia));

          // assert later
          final expected = [
            Loading(),
            Loaded(numberTrivia: tNumberTrivia),
          ];
          expectLater(tBloc, emitsInOrder(expected));
          // act
          tBloc.add(GetTriviaForConcreteNumber(tNumberString));
        },
      );
      test(
        'should emit [Loading, Error] when getting data fails',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          when(mockConcreteNumberTriviaUsecase(number: tNumberParsed))
              .thenAnswer((_) async => Left(ServerFailure()));

          // assert later
          final expectedStates = [
            Loading(),
            Error(errorMessage: SERVER_FAILURE_MESSAGE),
          ];
          expectLater(tBloc, emitsInOrder(expectedStates));
          // act
          tBloc.add(GetTriviaForConcreteNumber(tNumberString));
        },
      );
    },
  );

  group(
    'Get Trivia for randon Number',
    () {
      final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

      test(
        'should emit [Loading, Loaded] when data is gotten successfully',
        () async {
          // arrange

          when(mockRandomNumberTriviaUsecase())
              .thenAnswer((_) async => Right(tNumberTrivia));

          // assert later
          final expected = [
            Loading(),
            Loaded(numberTrivia: tNumberTrivia),
          ];
          expectLater(tBloc, emitsInOrder(expected));
          // act
          tBloc.add(GetTriviaForRandomNumber());
        },
      );
      test(
        'should emit [Loading, Error] when getting data fails',
        () async {
          // arrange

          when(mockRandomNumberTriviaUsecase())
              .thenAnswer((_) async => Left(ServerFailure()));

          // assert later
          final expectedStates = [
            Loading(),
            Error(errorMessage: SERVER_FAILURE_MESSAGE),
          ];
          expectLater(tBloc, emitsInOrder(expectedStates));
          // act
          tBloc.add(GetTriviaForRandomNumber());
        },
      );
    },
  );
}
