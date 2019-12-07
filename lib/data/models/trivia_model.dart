import 'package:json_annotation/json_annotation.dart';
import 'package:triviados/domain/entites/trivia.dart';

part 'trivia_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TriviaModel extends Trivia {

  TriviaModel(String question, String correctAnswer, List<String> incorrectAnswers)
      : super(question, correctAnswer, incorrectAnswers);

  factory TriviaModel.fromJson(Map<String, dynamic> json) => _$TriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$TriviaModelToJson(this);
}
