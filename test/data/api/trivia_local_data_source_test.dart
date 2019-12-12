import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/api/trivia_remote_data_source_impl.dart';
import 'package:triviados/data/local/trivia_loca_data_source.dart';
import 'package:triviados/data/local/trivia_local_data_source_impl.dart';
import 'package:triviados/data/models/trivia_model.dart';

import '../../utils/test_data_generator.dart';

/// Mock class of [SharedPreferences]
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TriviaLocalDataSource remoteDataSource;

  // Objects to be mocked
  SharedPreferences preferences;

  setUp(() {
    preferences = MockSharedPreferences();
    remoteDataSource = TriviaLocalDataSourceImpl(preferences);
  });

  final triviaList = generateTestTriviaModelList();

  test("Should return a cached trivia list from ShredPreferences", () async {});

  test('Should return CacheException when there is no data stored locally via SharedPreferences', () async {
//    expect(() => apiCall(), throwsA(TypeMatcher<ServerException>()));
  });

  test('Should call SharedPreferences to save the data locally', () async {});
}
