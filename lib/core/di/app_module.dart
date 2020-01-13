import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dependencies/dependencies.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviados/core/network/network_status.dart';
import 'package:triviados/data/api/trivia_remote_data_source.dart';
import 'package:triviados/data/api/trivia_remote_data_source_impl.dart';
import 'package:triviados/data/local/trivia_loca_data_source.dart';
import 'package:triviados/data/local/trivia_local_data_source_impl.dart';
import 'package:triviados/data/repositories/trivia_repository_impl.dart';
import 'package:triviados/domain/repositories/trivia_repository.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      // Network
      ..bindSingleton(NetworkStatus(DataConnectionChecker()))
      ..bindSingleton(Dio(BaseOptions(baseUrl: "https://opentdb.com/api.php", connectTimeout: 5000, receiveTimeout: 3000)))
      ..bindLazySingleton((injector, params) async => await SharedPreferences.getInstance())
      // Remote data source
      ..bindFactory<TriviaRemoteDataSource>((injector, params) => TriviaRemoteDataSourceImpl(injector.get()))
      // Local data source
      ..bindFactory<TriviaLocalDataSource>((injector, params) => TriviaLocalDataSourceImpl(injector.get()))
      // Repository
      ..bindFactory<TriviaRepository>((injector, params) => TriviaRepositoryImpl(injector.get(), injector.get(), injector.get()))
      // Use cases
      ..bindFactory((injector, params) => GetTriviaList(injector.get()));
  }
}
