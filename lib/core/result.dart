

/// A generic class to handle the result for each transaction.
abstract class Result<R> {}

class Success<T> extends Result<T> {
  T data;
  Success(this.data);
}

class Error extends Result<void> {
  Exception exception;
}
