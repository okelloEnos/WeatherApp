import '../../weather_barrel.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherRemoteDataSource _remoteDataSource;

  WeatherRepositoryImpl({required WeatherRemoteDataSource remoteDataSource}) :
        _remoteDataSource = remoteDataSource ;

  @override
  Future<List<CityEntity>> fetchCitiesRequest({required String locationName}) async{
    List<CityEntity> listOfCities = [];
    final response = await _remoteDataSource.fetchCitiesRequest(locationName: locationName);
    listOfCities = List.from(response).map((e) => CityModel.fromJson(e).toEntity()).toList();
    return listOfCities;
  }

  @override
  Future<WeatherEntity> fetchCurrentWeatherRequest({required CityEntity city}) async{
   WeatherEntity currentWeather = const WeatherEntity();
   final response = await _remoteDataSource.fetchCurrentWeatherRequest(city: city.toModel());
   currentWeather = WeatherModel.fromJson(response).toEntity();
   return currentWeather;
  }

  @override
  Future<List<WeatherEntity>> fetchPredictedWeatherRequest({required CityEntity city, required int days}) async{
    List<WeatherEntity> predictedWeatherList = [];
    final response = await _remoteDataSource.fetchPredictedWeatherRequest(city: city.toModel(), days: days);
    predictedWeatherList = List.from(response['list']).map((e) => WeatherModel.fromJson(e).toEntity()).toList();
    return predictedWeatherList;
  }


}