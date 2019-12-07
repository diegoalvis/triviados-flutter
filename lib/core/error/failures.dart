import 'package:triviados/core/result.dart';

class ServerFailure extends CustomError implements Result {
  ServerFailure({Exception exception}) : super(exception: exception);
}

class CacheFailure extends CustomError implements Result {
  CacheFailure({Exception exception}) : super(exception: exception);
}
