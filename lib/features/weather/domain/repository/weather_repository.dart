

import '../../weather_barrel.dart';

abstract class WeatherRepository {

  Future<WeatherEntity> fetchCurrentWeatherRequest({required String locationName});

  Future<List<WeatherEntity>> fetchPredictedWeatherRequest({required String locationName, required int days});
}