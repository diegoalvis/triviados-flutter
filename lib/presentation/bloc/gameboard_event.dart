import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Events
@immutable
abstract class GameEvent extends Equatable {
  GameEvent([List props = const <dynamic>[]]) : super(props);
}

class PlayEvent extends GameEvent {}

class OptionSelectedEvent extends GameEvent {
  final String answer;

  OptionSelectedEvent(this.answer);
}

class NextQuestionEvent extends GameEvent {}

class ExitGameEvent extends GameEvent {}
