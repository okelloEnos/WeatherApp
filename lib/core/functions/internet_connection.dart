import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  var connectionTwo = (await Connectivity().checkConnectivity()).first != ConnectivityResult.none;
  // var connection = await InternetConnectionChecker.instance.hasConnection;
  var connection = await InternetConnectionChecker().hasConnection;
  return (connection && connectionTwo);
}