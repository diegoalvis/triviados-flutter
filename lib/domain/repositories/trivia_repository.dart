import 'package:triviados/core/result.dart';

abstract class TriviaRepository {
  /// Fetch a trivia list.
  Future<Result> getTriviaList();
}
