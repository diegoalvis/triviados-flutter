import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/data/models/trivia_model.dart';

abstract class TriviaLocalDataSource {
  /// Fetch a trivia list from local storage.
  /// Throws [CacheException] if no cached data is present.
  Future<List<TriviaModel>> getTriviaList();

  /// Save data locally.
  Future saveTriviaList(List<TriviaModel> triviaList);
}
