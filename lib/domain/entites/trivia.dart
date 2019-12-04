import 'package:triviados/data/models/trivia_model.dart';

class Trivia {
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;


  Trivia(this.question, this.correctAnswer, this.incorrectAnswers);

  Trivia.fromModel(TriviaModel model, this.question) {
    this.question = model.question;
    this.correctAnswer = model.correctAnswer;
    this.incorrectAnswers = model.incorrectAnswers;
  }
}
