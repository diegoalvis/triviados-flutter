import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Events
@immutable
abstract class GameEvent extends Equatable {
  GameEvent([List props = const <dynamic>[]]) : super(props);
}

class PlayEvent extends GameEvent {}

class TriviaOptionSelectedEvent extends GameEvent {
  final String answer;

  TriviaOptionSelectedEvent(this.answer);
}

class NextEvent extends GameEvent {}

class FinishGameEvent extends GameEvent {}

class ExitGameEvent extends GameEvent {}
