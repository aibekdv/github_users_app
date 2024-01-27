import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_users_api/feature/data/data.dart';
import 'package:github_users_api/feature/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/presentation/presentation.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC & CUBIT
  sl.registerFactory(() => UsersApiCubit(sl()));
  sl.registerFactory(() => LangCubit(sl()));
  sl.registerFactory(() => ConnectivityCubit(Connectivity()));

  // GITHUB API
  sl.registerLazySingleton<GithubRemoteDataSource>(() => GithubRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<GithubRepository>(() => GithubRepositoryImpl(sl()));

  // EXTERNAL
  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
  sl.registerLazySingleton(() => Dio(BaseOptions(baseUrl: "https://api.github.com/")));
}