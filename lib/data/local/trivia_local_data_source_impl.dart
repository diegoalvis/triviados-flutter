import 'package:triviados/data/local/trivia_loca_data_source.dart';
import 'package:triviados/data/models/trivia_model.dart';

class TriviaLocalDataSourceImpl implements TriviaLocalDataSource {

  @override
  Future saveTriviaList(List<TriviaModel> triviaList) {
    // TODO: implement saveTriviaList
    return null;
  }

  @override
  Future<List<TriviaModel>> getTriviaList() {
    final lastTriviaList =generateTestTriviaModelList();
    return Future.value(lastTriviaList);
  }
}

/// Method should be removed *testing purposes*
List<TriviaModel> generateTestTriviaModelList() {
  return List.generate(10, (i) => TriviaModel("q $i", "answer $i", ["error 1", "error 2", "error 3"]));
}

