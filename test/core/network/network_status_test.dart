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
    networkStatus = NetworkStatus(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the DataConnectionChecker.hasConnection call',
      () async {
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);

        final result = networkStatus.isConnected;

        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
