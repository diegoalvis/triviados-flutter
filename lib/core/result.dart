import 'package:equatable/equatable.dart';

/// A generic class to handle the result for each transaction.
abstract class Result {}

class Success<T> extends Equatable implements Result {
  final T data;

  Success(this.data) : super([data]);
}

class CustomError extends Equatable implements Result {
  final Exception exception;

  CustomError([this.exception]) : super();
}

class ServiceError extends CustomError {
  final int code;

  ServiceError(this.code, Exception exception) : super(exception);
}
