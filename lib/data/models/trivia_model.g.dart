// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriviaModel _$TriviaModelFromJson(Map<String, dynamic> json) {
  return TriviaModel(
    json['question'] as String,
    json['correctAnswer'] as String,
    (json['incorrectAnswers'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TriviaModelToJson(TriviaModel instance) =>
    <String, dynamic>{
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'incorrectAnswers': instance.incorrectAnswers,
    };
