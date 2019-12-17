import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/local/trivia_loca_data_source.dart';
import 'package:triviados/data/models/trivia_model.dart';

class TriviaLocalDataSourceImpl implements TriviaLocalDataSource {
  static const String TRIVIA_KEY = "trivias";

  final SharedPreferences preferences;

  TriviaLocalDataSourceImpl(this.preferences);

  @override
  Future saveTriviaList(List<TriviaModel> triviaList) {
    final data = json.encode(triviaList);
    preferences.setString(TRIVIA_KEY, data);
    return null;
  }

  @override
  List<TriviaModel> getTriviaList() {
    final data = preferences.get(TRIVIA_KEY);
    if (data != null) {
      return data as List<TriviaModel>;
    } else {
      throw CacheException();
    }
  }
}
