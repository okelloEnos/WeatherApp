import '../../weather_barrel.dart';

class FetchCityListUseCase {
  final WeatherRepository _repository;

  FetchCityListUseCase({required WeatherRepository repository}) : _repository = repository;

  Future<List<CityEntity>> call({required String locationName}) async {
    return await _repository.fetchCitiesRequest(locationName: locationName);
  }
}