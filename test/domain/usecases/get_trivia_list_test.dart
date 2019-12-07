import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/domain/entites/trivia.dart';
import 'package:triviados/domain/repositories/trivia_repository.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';

/// Mock class of [TriviaRepository]
class MockTriviaRepository extends Mock implements TriviaRepository {}

void main() {
  GetTriviaList usecase;
  MockTriviaRepository mockTriviaRepository;

  setUp(() {
    mockTriviaRepository = MockTriviaRepository();
    usecase = GetTriviaList(mockTriviaRepository);
  });

  final List<Trivia> testTrivias = List.generate(10, (i) => Trivia("q $i", "answer $i", ["error 1", "error 2", "error 3"]));

  test("Get Trivia List Successfully", () async {
    when(mockTriviaRepository.getTriviaList()).thenAnswer((_) async => Success(testTrivias));

    final Success result = await usecase();

    expect(result, Success(testTrivias));
    expect(result.data, testTrivias);

    verify(mockTriviaRepository.getTriviaList());
    verifyNoMoreInteractions(mockTriviaRepository);
  });


  test("Get Trivia List Error", () async {
    when(mockTriviaRepository.getTriviaList()).thenAnswer((_) async => CustomError());

    final result = await usecase();

    expect(result, CustomError());

    verify(mockTriviaRepository.getTriviaList());
    verifyNoMoreInteractions(mockTriviaRepository);
  });
}
