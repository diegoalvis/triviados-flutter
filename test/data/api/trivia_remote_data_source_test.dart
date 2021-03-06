import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/api/api_url.dart';
import 'package:triviados/data/api/trivia_remote_data_source_impl.dart';
import 'package:triviados/data/models/trivia_model.dart';

/// Mock class of [Dio]
class MockDio extends Mock implements Dio {}

void main() {
  TriviaRemoteDataSourceImpl remoteDataSource;

  // Objects to be mocked
  Dio dio;

  setUp(() {
    dio = MockDio();
    remoteDataSource = TriviaRemoteDataSourceImpl(dio);
  });

  test('Should return List of Trivias when the response code is 200 (success)', () async {
    final mockResponse = File("test/utils/trivia_list.json").readAsStringSync();
    final triviaList = remoteDataSource.parseJsonResponse(json.decode(mockResponse)["results"]);

    when(dio.get(getTriviaPath, queryParameters: anyNamed("queryParameters")))
        .thenAnswer((_) async => Response(data: json.decode(mockResponse), statusCode: 200));

    final result = await remoteDataSource.getTriviaList();

    expect(result, equals(triviaList));
  });

  test('Should return ServerException when the response code is 404 (not found)', () async {
    when(dio.get(getTriviaPath, queryParameters: anyNamed("queryParameters")))
        .thenAnswer((_) async => Response(data: "Something went wrong.", statusCode: 404));

    final apiCall = remoteDataSource.getTriviaList;

    expect(() => apiCall(), throwsA(TypeMatcher<ServerException>()));
  });
}
