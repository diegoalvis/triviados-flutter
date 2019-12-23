import 'package:bloc/bloc.dart';
import 'package:triviados/core/error/failures.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/domain/entites/trivia.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';
import 'package:triviados/presentation/bloc/gameboard_event.dart';
import 'package:triviados/presentation/bloc/gameboard_state.dart';

class GameBoardBloc extends Bloc<GameEvent, TriviaState> {
  final GetTriviaList getTriviaList;

  List<Trivia> triviaList;
  int currentTriviaIndex = 0;
  int correctCount = 0;

  GameBoardBloc(this.getTriviaList);

  @override
  TriviaState get initialState => InitialState();

  @override
  Stream<TriviaState> mapEventToState(GameEvent event) async* {
    if (event is PlayEvent) {
      yield LoadingState();
      yield* _failureOrTriviaList();
    } else if (event is NextQuestionEvent) {
      yield ShowTrivia(triviaList.elementAt((currentTriviaIndex + 1) % triviaList.length));
    } else if (event is OptionSelectedEvent) {
      triviaList.elementAt(currentTriviaIndex).optionSelected = event.answer;
      yield AnswerSelected(triviaList.elementAt(currentTriviaIndex));
    } else if (event is FinishGameEvent) {
      yield GameFinished(_calculateScore());
    } else if (event is ExitGameEvent) {
      yield InitialState();
    } else {
      yield InitialState();
    }
  }

  Stream<TriviaState> _failureOrTriviaList() async* {
    final result = await getTriviaList.call();
    if (result is Success<List<Trivia>>) {
      triviaList = result.data;
      yield TriviasLoaded(result.data.first);
    } else {
      String errorMessage = "Somethig went wrong. Plese try again.";
      if (result is ServerFailure) {
        errorMessage = "There was a problem with the connection. Please try again";
      } else if (result is CacheFailure) {
        errorMessage = "There is no data to show. Please try again later.";
      }
      yield ErrorState(message: errorMessage);
    }
  }


  int _calculateScore() {
    return ((correctCount / triviaList.length) * 100).toInt();
  }
}
