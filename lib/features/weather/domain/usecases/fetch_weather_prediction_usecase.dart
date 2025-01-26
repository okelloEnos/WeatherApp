import '../../weather_barrel.dart';

class FetchWeatherPredictionUseCase {

  final WeatherRepository _repository;

  FetchWeatherPredictionUseCase({required WeatherRepository repository}) : _repository = repository;

  Future<List<WeatherEntity>> call({required CityEntity city, required int days}) async {
    return await _repository.fetchPredictedWeatherRequest(city: city, days: days);
  }
}