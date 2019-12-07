// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriviaModel _$TriviaModelFromJson(Map<String, dynamic> json) {
  return TriviaModel(
    json['question'] as String,
    json['correct_answer'] as String,
    (json['incorrect_answers'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TriviaModelToJson(TriviaModel instance) =>
    <String, dynamic>{
      'question': instance.question,
      'correct_answer': instance.correctAnswer,
      'incorrect_answers': instance.incorrectAnswers,
    };
