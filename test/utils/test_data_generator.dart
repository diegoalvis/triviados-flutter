import 'package:triviados/data/models/trivia_model.dart';
import 'package:triviados/domain/entites/trivia.dart';


List<TriviaModel> generateTestTriviaModelList() {
  return List.generate(10, (i) => TriviaModel("q $i", "answer $i", ["error 1", "error 2", "error 3"]));
}

List<Trivia> generateTestTriviaList() => generateTestTriviaModelList();