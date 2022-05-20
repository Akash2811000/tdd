import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_flutter/core/network/network_info.dart';
import 'package:tdd_flutter/core/util/input_converter.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_triva_local_datasource.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_concrte_number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(), getRandomNumberTrivia: sl()));



  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));



  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetWorkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
