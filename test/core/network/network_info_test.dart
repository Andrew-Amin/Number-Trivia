import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockDataConnectionChecker;
  NetworkInfoImp networkInfoImp;
  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImp =
        NetworkInfoImp(dataConnectionChecker: mockDataConnectionChecker);
  });

  test(
    'should forward the call to DataConnectionChecker.hasConnection',
    () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      // act
      // NOTICE: We're NOT awaiting the result
      final result = networkInfoImp.isConnected;
      // assert
      verify(mockDataConnectionChecker.hasConnection);
      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      expect(result, tHasConnectionFuture);
    },
  );
}
