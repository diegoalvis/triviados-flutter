import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:triviados/core/error/exceptions.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/domain/repositories/trivia_repository.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';

import '../../utils/test_data_generator.dart';

/// Mock class of [TriviaRepository]
class MockTriviaRepository extends Mock implements TriviaRepository {}

void main() {
  GetTriviaList usecase;
  MockTriviaRepository mockTriviaRepository;

  setUp(() {
    mockTriviaRepository = MockTriviaRepository();
    usecase = GetTriviaList(mockTriviaRepository);
  });

  test("Get Trivia List Successfully", () async {
    final triviaList = generateTestTriviaList();
    when(mockTriviaRepository.getTriviaList()).thenAnswer((_) async => Success(triviaList));

    final Success result = await usecase();

    verify(mockTriviaRepository.getTriviaList());
    verifyNoMoreInteractions(mockTriviaRepository);

    expect(result, Success(triviaList));
    expect(result.data, triviaList);
  });


  test("Get Trivia List Error", () async {
    when(mockTriviaRepository.getTriviaList()).thenAnswer((_) async => CustomError());

    final result = await usecase();

    verify(mockTriviaRepository.getTriviaList());
    verifyNoMoreInteractions(mockTriviaRepository);

    expect(result, equals(CustomError()));
  });
}
