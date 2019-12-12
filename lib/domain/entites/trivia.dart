import 'package:equatable/equatable.dart';

class Trivia extends Equatable {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Trivia(this.question, this.correctAnswer, this.incorrectAnswers) : super([question, correctAnswer, incorrectAnswers]);
}
