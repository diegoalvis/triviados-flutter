import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/core/error/failures.dart';
import 'package:triviados/core/network/network_status.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/data/api/trivia_remote_data_source.dart';
import 'package:triviados/data/local/trivia_loca_data_source.dart';
import 'package:triviados/domain/repositories/trivia_repository.dart';

class TriviaRepositoryImpl extends TriviaRepository {
  final TriviaRemoteDataSource remoteDataSource;
  final TriviaLocalDataSource localDataSource;
  final NetworkStatus networkStatus;

  TriviaRepositoryImpl(this.networkStatus, this.remoteDataSource, this.localDataSource);

  @override
  Future<Result> getTriviaList() async {
    if (await networkStatus.isConnected) {
      try {
        final remoteTriviaList = await remoteDataSource.getTriviaList();
        localDataSource.saveTriviaList(remoteTriviaList);
        return Success(remoteTriviaList);
      } on ServerException {
        return _getLocalData();
      } catch (e) {
        return ServerFailure();
      }
    } else {
      return await _getLocalData();
    }
  }

  Future<Result> _getLocalData() async {
    try {
      final localTriviaList = await localDataSource.getTriviaList();
      return Success(localTriviaList);
    } on CacheException {
      return CacheFailure();
    }
  }
}
