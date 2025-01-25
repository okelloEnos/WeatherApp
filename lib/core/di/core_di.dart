import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get_it/get_it.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:telephony/telephony.dart';

import '../api/api.dart';
import '../core_barrel.dart';
import '../data/datasources/sr_remote_data_source.dart';
import '../util/pdfs/pdf_quotation.dart';

const int timer = 5;

// Future<void> reRegisterDio() async {
//   if (locator.isRegistered<Dio>()) {
//     locator.unregister<Dio>();
//     locator.registerSingleton(Dio(BaseOptions(
//         baseUrl: Api.baseUrl,
//         receiveDataWhenStatusError: true,
//         connectTimeout: connectTimeout,
//         sendTimeout: sendTimeout,
//         receiveTimeout: receiveTimeout,
//         contentType: 'application/json',
//         headers: {
//           'Authorization':
//               'Bearer ${locator<SharedPreferencesUtil>().getValidToken()}'
//         })));
//   }
// }

Future<void> invokeCoreDI({required GetIt locator}) async {

  /// Zoom Drawer
  locator.registerLazySingleton<ZoomDrawerController>(() => ZoomDrawerController());

  /// Device Info Plugin
  locator.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  /// User Session
  locator.registerLazySingleton<StreamController<SessionState>>(
      () => StreamController<SessionState>());

  locator.registerLazySingleton<SessionConfig>(() => SessionConfig(
      invalidateSessionForUserInactivity: inactivityTimeout,
      invalidateSessionForAppLostFocus: appFocusTimeout));

  /// Shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  locator.registerSingleton<SharedPreferencesUtil>(
      SharedPreferencesUtil(sharedPreferences: sharedPreferences));

  /// DIO
  locator.registerLazySingleton<Dio>(() {
    return Dio(BaseOptions(
        baseUrl: Api.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: connectTimeout,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        contentType: 'application/json',
        headers: {
          'Authorization':
              'Bearer ${locator<SharedPreferencesUtil>().getValidToken()}'
        }));
  });

  /// pdf
  locator.registerLazySingleton<PdfQuotation>(
          () => PdfQuotation());
}
