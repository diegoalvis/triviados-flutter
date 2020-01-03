import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';
import 'package:triviados/presentation/bloc/gameboard_bloc.dart';
import 'package:triviados/presentation/bloc/gameboard_event.dart';
import 'package:triviados/presentation/bloc/gameboard_state.dart';

import '../../utils/test_data_generator.dart';

class MockGetTriviaList extends Mock implements GetTriviaList {}

void main() {
  // ignore: close_sinks
  GameBoardBloc gameBoardBloc;

  // Objects to be mocked
  MockGetTriviaList mockGetTriviaList;

  setUp(() {
    mockGetTriviaList = MockGetTriviaList();
    gameBoardBloc = GameBoardBloc(mockGetTriviaList);
  });

  test("Should call get trivia list use case when the play event is received", () async {
    final triviaList = generateTestTriviaList(5);

    when(mockGetTriviaList.call()).thenAnswer((_) async => Success(triviaList));

    gameBoardBloc.add(PlayEvent());
    await untilCalled(mockGetTriviaList.call());

    verify(mockGetTriviaList.call());
  });

  group("GameBoardBloc", () {
    final triviaList = generateTestTriviaList(10);

    blocTest(
      "Should emit loading and loaded states when the data is gotten successfully.",
      build: () => gameBoardBloc,
      act: (bloc) {
        when(mockGetTriviaList.call()).thenAnswer((_) async => Success(triviaList));

        return bloc.add(PlayEvent());
      },
      expect: [InitialState(), LoadingState(), TriviasLoaded(triviaList.first)],
    );

    blocTest(
      "Should emit loading and error states when the data can't be gotten.",
      build: () => gameBoardBloc,
      act: (bloc) {
        when(mockGetTriviaList.call()).thenAnswer((_) async => CustomError());

        return bloc.add(PlayEvent());
      },
      expect: [InitialState(), LoadingState(), TypeMatcher<ErrorState>()],
    );

    blocTest(
      "Should emit showTrivia when the event next is received.",
      build: () {
        gameBoardBloc.triviaList = triviaList;
        gameBoardBloc.currentTriviaIndex = 1;

        return gameBoardBloc;
      },
      act: (bloc) {
        return bloc.add(NextQuestionEvent());
      },
      expect: [InitialState(), ShowTrivia(triviaList[2])],
    );

    blocTest(
      "Should emit answer selected state when an answer of the trivia is selected.",
      build: () {
        gameBoardBloc.triviaList = triviaList;
        return gameBoardBloc;
      },
      act: (bloc) {
        final answer = triviaList.elementAt(bloc.currentTriviaIndex).correctAnswer;
        return bloc.add(OptionSelectedEvent(answer));
      },
      expect: [InitialState(), AnswerSelected()],
    );

    blocTest(
      "Should emit incorrect answer state when the correct answer of the trivia is selected.",
      build: () {
        gameBoardBloc.triviaList = triviaList;
        return gameBoardBloc;
      },
      act: (bloc) {
        final answer = triviaList.elementAt(gameBoardBloc.currentTriviaIndex).incorrectAnswers.first;
        return bloc.add(OptionSelectedEvent(answer));
      },
      expect: [InitialState(), IncorrectAnswer()],
    );

    blocTest(
      "Should emit game finish state when the game has been finished and initial state after exit game.",
      build: () {
        gameBoardBloc.triviaList = triviaList;
        gameBoardBloc.correctCount = 3;
        return gameBoardBloc;
      },
      act: (bloc) {
        bloc.add(FinishGameEvent());
        return bloc.add(ExitGameEvent());
      },
      expect: [InitialState(), GameFinished(((3 / triviaList.length) * 100).toInt()), InitialState()],
    );
  });
}
