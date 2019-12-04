import 'package:json_annotation/json_annotation.dart';

part 'trivia_model.g.dart';

@JsonSerializable(nullable: true)
class TriviaModel {
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  TriviaModel(this.question, this.correctAnswer, this.incorrectAnswers);

  factory TriviaModel.fromJson(Map<String, dynamic> json) =>
      _$TriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$TriviaModelToJson(this);
}
