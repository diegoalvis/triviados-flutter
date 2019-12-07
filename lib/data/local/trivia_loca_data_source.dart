import 'package:triviados/data/models/trivia_model.dart';

abstract class TriviaLocalDataSource {
  /// Fetch a trivia list from local storage.
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<List<TriviaModel>> getTriviaList();

  /// save data locally.
  Future saveTriviaList(List<TriviaModel> triviaList);
}
