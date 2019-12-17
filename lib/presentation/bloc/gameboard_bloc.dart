import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:triviados/domain/entites/trivia.dart';

class GameBoardBloc extends Bloc<GameEvent, TriviaState> {

  @override
  TriviaState get initialState => InitialTriviaState();

  @override
  Stream<TriviaState> mapEventToState(GameEvent event) {
    // TODO: implement mapEventToState
    return null;
  }

}


/// Events
enum GameEvent { play, optionSelected, next, finish, exit}

/// States
@immutable
abstract class TriviaState extends Equatable {
  TriviaState([List props = const <dynamic>[]]) : super(props);
}

class InitialTriviaState extends TriviaState {}

class LoadingState extends TriviaState {}

class TriviaListLoaded extends TriviaState {}

class ShowTrivia extends TriviaState {
  final Trivia trivia;

  ShowTrivia(this.trivia) : super([trivia]);
}

class CorrectAnswerState extends TriviaState {}

class IncorrectAnswerState extends TriviaState {}

class GameFinished extends TriviaState {
  final int score;

  GameFinished(this.score);
}