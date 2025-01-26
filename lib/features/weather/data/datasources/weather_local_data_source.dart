import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/values/values_barrel.dart';

abstract class WeatherLocalDataSource {
  Future<void> saveCurrentWeather({required dynamic weatherResponse});
  Future<void> savePredictedWeather({required dynamic weatherResponse});
  Future<dynamic> getCurrentWeather();
  Future<dynamic> getPredictedWeather();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  const WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveCurrentWeather({required dynamic weatherResponse}) async {
    await sharedPreferences.setString(
      Constants.currentWeatherKey,
      jsonEncode(weatherResponse),
    );
  }

  @override
  Future<void> savePredictedWeather({required dynamic weatherResponse}) async {
    await sharedPreferences.setString(
      Constants.predictedWeatherKey,
      jsonEncode(weatherResponse),
    );
  }

  @override
  Future<dynamic> getCurrentWeather() async {
    final currentWeather = sharedPreferences.getString(Constants.currentWeatherKey);
    return currentWeather != null ? jsonDecode(currentWeather) : null;
  }

  @override
  Future<dynamic> getPredictedWeather() async {
    final predictedWeather = sharedPreferences.getString(Constants.predictedWeatherKey);
    return predictedWeather != null ? jsonDecode(predictedWeather) : null;
  }
}