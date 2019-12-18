import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/core/error/failures.dart';
import 'package:triviados/core/network/network_status.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/data/api/trivia_remote_data_source.dart';
import 'package:triviados/data/local/trivia_loca_data_source.dart';
import 'package:triviados/data/repositories/trivia_repository_impl.dart';
import 'package:triviados/domain/repositories/trivia_repository.dart';

import '../../utils/test_data_generator.dart';

/// Mock class of [TriviaRemoteDataSource]
class MockTriviaRemoteDataSource extends Mock implements TriviaRemoteDataSource {}

/// Mock class of [TriviaLocalDataSource]
class MockTriviaLocalDataSource extends Mock implements TriviaLocalDataSource {}

/// Mock class of [NetworkStatus]
class MockNetworkStatus extends Mock implements NetworkStatus {}

void main() {
  TriviaRepository triviaRepository;

  // Objects to be mocked
  TriviaRemoteDataSource remoteDataSource;
  TriviaLocalDataSource localDataSource;
  NetworkStatus networkStatus;

  setUp(() {
    remoteDataSource = MockTriviaRemoteDataSource();
    localDataSource = MockTriviaLocalDataSource();
    networkStatus = MockNetworkStatus();
    triviaRepository = TriviaRepositoryImpl(networkStatus, remoteDataSource, localDataSource);
  });

  // DEVICE IS ONLINE
  group('Online mode', () {
    final triviaList = generateTestTriviaModelList(4);

    setUp(() {
      when(networkStatus.isConnected).thenAnswer((_) async => true);
    });

    test("check if device has internet connection", () async {
      triviaRepository.getTriviaList();
      verify(networkStatus.isConnected);
    });

    test("should return data succesfully from the remote source", () async {
      when(remoteDataSource.getTriviaList()).thenAnswer((_) async => triviaList);

      final result = await triviaRepository.getTriviaList();

      verify(remoteDataSource.getTriviaList());
      expect(result, Success(triviaList));
    });


    test("should save locally the returned data from the remote source", () async {
      when(remoteDataSource.getTriviaList()).thenAnswer((_) async => triviaList);

      await triviaRepository.getTriviaList();

      verify(remoteDataSource.getTriviaList());
      verify(localDataSource.saveTriviaList(triviaList));
    });

    test("should local data if there is a failure accessing to the data from the remote source", () async {
      when(remoteDataSource.getTriviaList()).thenThrow(ServerException());
      when(localDataSource.getTriviaList()).thenReturn(triviaList);

      final result = await triviaRepository.getTriviaList();

      verify(remoteDataSource.getTriviaList());
      verify(localDataSource.getTriviaList());
      verifyNoMoreInteractions(remoteDataSource);
      expect(result, Success(triviaList));
    });
  });


  // DEVICE IS OFFLINE
  group('Offline mode', () {
    final triviaList = generateTestTriviaModelList(9);

    setUp(() {
      when(networkStatus.isConnected).thenAnswer((_) async => false);
    });

    test("should return data from the local source", () async {
      when(localDataSource.getTriviaList()).thenReturn(triviaList);

      final result = await triviaRepository.getTriviaList();

      verify(localDataSource.getTriviaList());
      verifyNoMoreInteractions(remoteDataSource);
      expect(result, Success(triviaList));
    });


    test("should return cache failure when there is no data stored locally", () async {
      when(localDataSource.getTriviaList()).thenThrow(CacheException());

      final result = await triviaRepository.getTriviaList();

      verify(localDataSource.getTriviaList());
      expect(result, equals(CacheFailure()));
    });
  });
}
