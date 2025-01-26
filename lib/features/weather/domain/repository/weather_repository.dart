

import '../../weather_barrel.dart';

abstract class WeatherRepository {

  Future<List<CityEntity>> fetchCitiesRequest({required String locationName});

  Future<WeatherEntity> fetchCurrentWeatherRequest({required CityEntity city});

  Future<List<WeatherEntity>> fetchPredictedWeatherRequest({required CityEntity city, required int days});
}