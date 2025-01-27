import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/core_barrel.dart';
import 'package:weather_app/core/values/constants.dart';

import '../../../../core/functions/functions_barrel.dart';
import '../../weather_barrel.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;

  WeatherRepositoryImpl({required WeatherRemoteDataSource remoteDataSource, required WeatherLocalDataSource localDataSource}) :
        _remoteDataSource = remoteDataSource, _localDataSource = localDataSource;

  @override
  Future<List<CityEntity>> fetchCitiesRequest({required String locationName}) async{
    List<CityEntity> listOfCities = [];
    final response = await _remoteDataSource.fetchCitiesRequest(locationName: locationName);
    listOfCities = List.from(response).map((e) => CityModel.fromJson(e).toEntity()).toList();
    return listOfCities;
  }

  @override
  Future<WeatherEntity> fetchCurrentWeatherRequest({required CityEntity city}) async{
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferences sharedPreferences = locator<SharedPreferences>();
    WeatherEntity currentWeather = const WeatherEntity();

   // final response = await _remoteDataSource.fetchCurrentWeatherRequest(city: city.toModel());
   // currentWeather = WeatherModel.fromJson(response).toEntity();
   // return currentWeather;
    bool isConnected = await hasInternetConnection();
    if (isConnected) {
      // fetch from remote
      final response = await _remoteDataSource.fetchCurrentWeatherRequest(city: city.toModel());
      currentWeather = WeatherModel.fromJson(response).toEntity();

      if (currentWeather.dateTime != null) {
        // clear current weather
        await sharedPreferences.setString(Constants.currentWeatherKey, "");

        // insert current weather to local storage
        await _localDataSource.saveCurrentWeather(weatherResponse: response);
      }
    }

    // fetch from local storage
    final response = await _localDataSource.getCurrentWeather();
    currentWeather = WeatherModel.fromJson(response).toEntity();
    return currentWeather;
  }

  @override
  Future<List<WeatherEntity>> fetchPredictedWeatherRequest({required CityEntity city, required int days}) async{
    // List<WeatherEntity> predictedWeatherList = [];
    // final response = await _remoteDataSource.fetchPredictedWeatherRequest(city: city.toModel(), days: days);
    // predictedWeatherList = List.from(response['list']).map((e) => WeatherModel.fromJson(e).toEntity()).toList();
    // return predictedWeatherList;

    SharedPreferences sharedPreferences = locator<SharedPreferences>();
    List<WeatherEntity> predictedWeatherList = [];

    bool isConnected = await hasInternetConnection();
    if (isConnected) {
      // fetch from remote
      final response = await _remoteDataSource.fetchPredictedWeatherRequest(city: city.toModel(), days: days);
      predictedWeatherList = List.from(response['list']).map((e) => WeatherModel.fromJson(e).toEntity()).toList();

      if (predictedWeatherList.isNotEmpty) {
        // clear weather predictions
        await sharedPreferences.setString(Constants.predictedWeatherKey, "");

        // insert weather predictions to local storage
        await _localDataSource.savePredictedWeather(weatherResponse: response);
      }
    }

    // fetch from local storage
    final response = await _localDataSource.getPredictedWeather();
    predictedWeatherList = List.from(response['list']).map((e) => WeatherModel.fromJson(e).toEntity()).toList();


    DateTime now = DateTime.now();
    final filteredData = predictedWeatherList.where((entry) {
      bool validEntry = false;
      final DateTime entryTime = DateTime.fromMillisecondsSinceEpoch(int.parse(entry.dateTime!) * 1000, isUtc: true);
      if(entryTime.isAfter(now.add(const Duration(hours: 24)))){
        now = now.add(const Duration(hours: 24));
        validEntry = true;
      }
      return validEntry;
    }).toList();

    if(filteredData.length > 5){
      predictedWeatherList = filteredData.sublist(0, 6);
    }
    else{
      predictedWeatherList = filteredData;
    }

    return predictedWeatherList;
  }


}