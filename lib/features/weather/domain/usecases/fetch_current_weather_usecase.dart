import '../../weather_barrel.dart';

class FetchCurrentWeatherUseCase {
  final WeatherRepository _repository;

  FetchCurrentWeatherUseCase({required WeatherRepository repository}) : _repository = repository;

  Future<WeatherEntity> call({required String locationName}) async {
    return await _repository.fetchCurrentWeatherRequest(locationName: locationName);
  }
}