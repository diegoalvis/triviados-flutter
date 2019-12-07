import 'package:dio/dio.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/api/trivia_remote_data_source.dart';
import 'package:triviados/data/models/trivia_model.dart';

class TriviaRemoteDataSourceImpl implements TriviaRemoteDataSource {
  // TODO should be injected
  Dio _dio;

  TriviaRemoteDataSourceImpl() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://opentdb.com/api.php",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
  }

  @override
  Future<List<TriviaModel>> getTriviaList() async {
    final result =
        await _dio.get("/", queryParameters: {"amount": 10, "type": "multiple"}).catchError((error) => ServerException());
    return result.data;
  }
}
