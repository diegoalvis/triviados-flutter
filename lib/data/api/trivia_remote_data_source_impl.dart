import 'package:dio/dio.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/api/trivia_remote_data_source.dart';
import 'package:triviados/data/models/trivia_model.dart';

import 'api_url.dart';

class TriviaRemoteDataSourceImpl implements TriviaRemoteDataSource {
  final Dio _dio;

  TriviaRemoteDataSourceImpl(this._dio);

  @override
  Future<List<TriviaModel>> getTriviaList() async {
    try {
      final response = await _dio.get(getTriviaPath, queryParameters: {"amount": 10, "type": "multiple"});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<TriviaModel> triviaList;
        if (response.data["results"] != null) {
          triviaList = parseJsonResponse(response.data["results"]);
        }
        return triviaList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw e;
    }
  }

  List<TriviaModel> parseJsonResponse(List data) {
    return data.map((json) => TriviaModel.fromJson(json)).toList();
  }
}
