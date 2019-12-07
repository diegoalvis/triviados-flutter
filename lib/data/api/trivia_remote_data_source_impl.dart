import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    return await _dio.get<Map<String, dynamic>>("/", queryParameters: {"amount": 10, "type": "multiple"}).then((response) async {
      List<TriviaModel> data;
      if (response.data["results"] != null) {
        data = await compute<List<Map<String, dynamic>>, List<TriviaModel>>(
            parseTriviaList, (response.data["results"] as List).cast<Map<String, dynamic>>());
      }
      return data;
    }).catchError((error) => ServerException());
  }
}

List<TriviaModel> parseTriviaList(List<Map<String, dynamic>> json) =>
    json.map((element) => TriviaModel.fromJson(element)).toList();
