import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';
import 'package:triviados/presentation/bloc/gameboard_bloc.dart';

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

  final triviaList = generateTestTriviaList();

  test("Should call get trivia list use case when the play event is received", () async {
    when(mockGetTriviaList.call()).thenAnswer((_) async => Success(triviaList));

    gameBoardBloc.add(GameEvent.play);
    await untilCalled(mockGetTriviaList.call());

    verify(mockGetTriviaList.call());
  });

  group("GameBoardBloc", () {
    blocTest(
      "Should emit inital, loading and loaded states when data is gotten successfully.",
      build: () => GameBoardBloc(mockGetTriviaList),
      act: (bloc) {
        when(mockGetTriviaList.call()).thenAnswer((_) async => Success(triviaList));

        return bloc.add(GameEvent.play);
      },
      expect: [InitialState(), LoadingState(), TriviasLoaded(triviaList.first)],
    );
  });
}
