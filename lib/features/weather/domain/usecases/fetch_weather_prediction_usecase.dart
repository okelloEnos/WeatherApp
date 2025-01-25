import '../../weather_barrel.dart';

class FetchWeatherPredictionUseCase {

  final WeatherRepository _repository;

  FetchWeatherPredictionUseCase({required WeatherRepository repository}) : _repository = repository;

  Future<List<WeatherEntity>> call({required String locationName, required int days}) async {
    return await _repository.fetchPredictedWeatherRequest(locationName: locationName, days: days);
  }
}