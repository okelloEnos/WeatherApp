import 'package:weather_app/features/features_barrel.dart';

import '../../weather_barrel.dart';

class FetchCurrentWeatherUseCase {
  final WeatherRepository _repository;

  FetchCurrentWeatherUseCase({required WeatherRepository repository}) : _repository = repository;

  Future<WeatherEntity> call({required CityEntity city}) async {
    return await _repository.fetchCurrentWeatherRequest(city: city);
  }
}