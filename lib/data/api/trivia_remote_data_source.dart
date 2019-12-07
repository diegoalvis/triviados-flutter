import 'package:triviados/data/models/trivia_model.dart';

abstract class TriviaRemoteDataSource {
  /// Fetch a trivia list from remote source through an API call.
  Future<List<TriviaModel>> getTriviaList();
}
