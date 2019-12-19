import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/api/trivia_remote_data_source.dart';
import 'package:triviados/data/models/trivia_model.dart';

import 'api_url.dart';

class TriviaRemoteDataSourceImpl implements TriviaRemoteDataSource {
  final Dio _dio;

  TriviaRemoteDataSourceImpl(this._dio);

  @override
  Future<List<TriviaModel>> getTriviaList() async {
    final response = await _dio.get(getTriviaPath, queryParameters: {"amount": 10, "type": "multiple"});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<TriviaModel> data;
      if (response.data["results"] != null) {
        data = await compute<List<Map<String, dynamic>>, List<TriviaModel>>(
            parseTriviaList, (response.data["results"] as List).cast<Map<String, dynamic>>());
      }
      return data;
    } else {
      throw ServerException();
    }
  }
}

// Isolate function to parse list
List<TriviaModel> parseTriviaList(List<Map<String, dynamic>> json) =>
    json.map((element) => TriviaModel.fromJson(element)).toList();
