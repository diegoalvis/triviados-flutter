import 'package:triviados/data/models/trivia_model.dart';
import 'package:triviados/domain/entites/trivia.dart';

List<Trivia> generateTestTriviaList() {
  return List.generate(10, (i) => Trivia("q $i", "answer $i", ["error 1", "error 2", "error 3"]));
}

List<TriviaModel> generateTestTriviaModelList() {
  return List.generate(10, (i) => TriviaModel("q $i", "answer $i", ["error 1", "error 2", "error 3"]));
}
