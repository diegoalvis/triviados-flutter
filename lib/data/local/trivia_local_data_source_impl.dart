import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviados/data/local/trivia_loca_data_source.dart';
import 'package:triviados/data/models/trivia_model.dart';

class TriviaLocalDataSourceImpl implements TriviaLocalDataSource {
  final SharedPreferences preferences;

  TriviaLocalDataSourceImpl(this.preferences);

  @override
  Future saveTriviaList(List<TriviaModel> triviaList) {
    // TODO: implement saveTriviaList
    return null;
  }

  @override
  Future<List<TriviaModel>> getTriviaList() {
    // TODO: implement
    return null;
  }
}
