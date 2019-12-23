import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:triviados/domain/entites/trivia.dart';

/// States
@immutable
abstract class TriviaState extends Equatable {
  TriviaState([List props = const <dynamic>[]]) : super(props);
}

class InitialState extends TriviaState {}

class LoadingState extends TriviaState {}

class TriviasLoaded extends TriviaState {
  final Trivia firstTrivia;

  TriviasLoaded(this.firstTrivia) : super([firstTrivia]);
}

class ShowTrivia extends TriviaState {
  final Trivia trivia;

  ShowTrivia(this.trivia) : super([trivia.question]);
}

class AnswerSelected extends TriviaState {
  final Trivia trivia;

  AnswerSelected(this.trivia): super([trivia.optionSelected]);
}

class ErrorState extends TriviaState {
  ErrorState({String message}) : super([message]);
}

class GameFinished extends TriviaState {
  final int score;

  GameFinished(this.score);
}
