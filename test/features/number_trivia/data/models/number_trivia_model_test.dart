import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test('NumberTriviaModel should be subclass of NumberTrivia', () {
    //verify
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('from json', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the JSON number is an double',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);
    });
  });

  group('to json', () {
    test('should return a JSON map containing the proper data', () {
      //arrange
      final Map<String, dynamic> expectedMap = {
        'text': 'Test Text',
        'number': 1
      };

      //act
      final result = tNumberTriviaModel.toJson();
      //assert
      expect(result, expectedMap);
    });
  });
}
