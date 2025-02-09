import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum NetworkStatus { notDetermined, on, off }

abstract class NetworkEvent {}

class CheckConnectedEvent extends NetworkEvent{
  final ConnectivityResult result;

  CheckConnectedEvent({required this.result});
}


class NetworkBloc extends Bloc<NetworkEvent, NetworkStatus> {
  NetworkBloc() : super(NetworkStatus.notDetermined) {
    _init();
    on<CheckConnectedEvent>(_checkConnected);
  }

  void _init(){
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      add(CheckConnectedEvent(result: result.first));
    });
  }

  void _checkConnected(CheckConnectedEvent event, Emitter<NetworkStatus> emit) async{
    var result = event.result;
    bool isConnected = false;

    if(result != ConnectivityResult.none){
      bool isOnline = await InternetConnectionChecker().hasConnection;
      isConnected = isOnline;
    }

    emit(isConnected ? NetworkStatus.on : NetworkStatus.off);
  }
}