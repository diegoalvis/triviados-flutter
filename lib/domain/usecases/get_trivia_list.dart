import 'package:triviados/core/result.dart';
import 'package:triviados/domain/repositories/trivia_repository.dart';

class GetTriviaList {
  final TriviaRepository _repository;

  GetTriviaList(this._repository);

  Future<Result> call() async {
    return await _repository.getTriviaList();
  }
}
