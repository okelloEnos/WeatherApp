import '../../weather_barrel.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherRemoteDataSource _remoteDataSource;

  WeatherRepositoryImpl({required WeatherRemoteDataSource remoteDataSource}) :
        _remoteDataSource = remoteDataSource ;

  @override
  Future<WeatherEntity> fetchCurrentWeatherRequest({required String locationName}) async{
   WeatherEntity currentWeather = const WeatherEntity();
   final response = await _remoteDataSource.fetchCurrentWeatherRequest(locationName: locationName);
   return currentWeather;
  }

  @override
  Future<List<WeatherEntity>> fetchPredictedWeatherRequest({required String locationName, required int days}) async{
    List<WeatherEntity> predictedWeatherList = [];
    final response = await _remoteDataSource.fetchPredictedWeatherRequest(locationName: locationName, days: days);
    return predictedWeatherList;
  }


}