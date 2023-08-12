import 'package:get_it/get_it.dart';
import 'package:github_users_app/data/api/api.dart';
import 'package:github_users_app/presentation/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC & CUBIT
  sl.registerFactory(() => UserCubit(sl()));
  sl.registerFactory(() => LanguageCubit(prefs: sl()));
  sl.registerFactory(() => ConnectionCubit());

  // GITHUB API
  sl.registerLazySingleton(() => GithubApi());

  // EXTERNAL
  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
}
