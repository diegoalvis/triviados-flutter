import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/local/trivia_local_data_source_impl.dart';

import '../../utils/test_data_generator.dart';

/// Mock class of [SharedPreferences]
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TriviaLocalDataSourceImpl localDataSource;

  // Objects to be mocked
  SharedPreferences preferences;

  setUp(() {
    preferences = MockSharedPreferences();
    localDataSource = TriviaLocalDataSourceImpl(preferences);
  });

  final triviaList = generateTestTriviaModelList(6);

  test("Should return a cached trivia list from ShredPreferences", () async {
    when(preferences.get(TriviaLocalDataSourceImpl.TRIVIA_KEY)).thenReturn(triviaList);

    final result = localDataSource.getTriviaList();

    expect(result, triviaList);
  });

  test('Should return CacheException when there is no data stored locally via SharedPreferences', () async {
    when(preferences.get(TriviaLocalDataSourceImpl.TRIVIA_KEY)).thenReturn(null);

    final call = localDataSource.getTriviaList;

    expect(() => call(), throwsA(TypeMatcher<CacheException>()));
  });

  test('Should call SharedPreferences to save the data locally', () async {
    localDataSource.saveTriviaList(triviaList);

    verify(preferences.setString(TriviaLocalDataSourceImpl.TRIVIA_KEY, json.encode(triviaList)));
  });
}
