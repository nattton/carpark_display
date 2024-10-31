import 'package:carpark_display/app.dart';
import 'package:carpark_display/data/service/api_service.dart';
import 'package:carpark_display/data/service/app_service.dart';
import 'package:carpark_display/domain/repository/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupDependencies();
  runApp(
    const App(),
  );
}

Future<void> _setupDependencies() async {
  final getIt = GetIt.instance;
  getIt.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await GetIt.instance.isReady<SharedPreferences>();
  getIt.registerSingleton(AppService(pref: getIt()));
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiRepository>(() => ApiService(getIt<Dio>()));
  await getIt.allReady();
}
