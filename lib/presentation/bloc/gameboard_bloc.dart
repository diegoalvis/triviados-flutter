import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/domain/entites/trivia.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';

class GameBoardBloc extends Bloc<GameEvent, TriviaState> {
  final GetTriviaList getTriviaList;

  GameBoardBloc(this.getTriviaList);

  @override
  TriviaState get initialState => InitialState();

  @override
  Stream<TriviaState> mapEventToState(GameEvent event) async* {
    switch (event) {
      case GameEvent.play:
        yield LoadingState();
        final result = await getTriviaList.call();
        if(result is Success<List<Trivia>>) {
          yield TriviasLoaded(result.data.first);
        } else {

        }
        break;
      case GameEvent.optionSelected:
        // TODO: Handle this case.
        break;
      case GameEvent.next:
        // TODO: Handle this case.
        break;
      case GameEvent.finish:
        // TODO: Handle this case.
        break;
      case GameEvent.exit:
        // TODO: Handle this case.
        break;
      default:
        yield InitialState();
    }
  }
}

/// Events
enum GameEvent { play, optionSelected, next, finish, exit }

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

  ShowTrivia(this.trivia) : super([trivia]);
}

class CorrectAnswer extends TriviaState {}

class IncorrectAnswer extends TriviaState {}

class ErrorLoading extends TriviaState {}

class GameFinished extends TriviaState {
  final int score;

  GameFinished(this.score);
}
