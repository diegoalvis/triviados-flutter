import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:triviados/core/network/network_status.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkStatus networkStatus;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkStatus= NetworkStatus(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
          () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
        // act
        // NOTICE: We're NOT awaiting the result
        final result = networkStatus.isConnected;
        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
