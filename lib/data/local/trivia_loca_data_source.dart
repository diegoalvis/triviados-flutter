import 'package:triviados/data/models/trivia_model.dart';

abstract class TriviaLocalDataSource {
  /// Fetch a trivia list from local storage.
  Future<List<TriviaModel>> getTriviaList();
}
