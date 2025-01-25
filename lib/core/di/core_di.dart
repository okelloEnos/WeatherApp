import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/values/values_barrel.dart';

Future<void> invokeCoreDI({required GetIt locator}) async {

  // /// Shared preferences
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  //
  // locator.registerSingleton<SharedPreferencesUtil>(
  //     SharedPreferencesUtil(sharedPreferences: sharedPreferences));

  /// DIO
  locator.registerLazySingleton<Dio>(() {
    return Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: Constants.connectTimeout,
        sendTimeout: Constants.sendTimeout,
        receiveTimeout: Constants.receiveTimeout,
        contentType: 'application/json',
        ));
  });

}
