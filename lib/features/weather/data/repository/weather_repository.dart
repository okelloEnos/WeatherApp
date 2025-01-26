import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/core_barrel.dart';
import 'package:weather_app/core/values/constants.dart';

import '../../../../core/functions/functions_barrel.dart';
import '../../weather_barrel.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;

  WeatherRepositoryImpl({required WeatherRemoteDataSource remoteDataSource, required WeatherLocalDataSource localDataSource}) :
        _remoteDataSource = remoteDataSource, _localDataSource = localDataSource;

  @override
  Future<List<CityEntity>> fetchCitiesRequest({required String locationName}) async{
    List<CityEntity> listOfCities = [];
    final response = await _remoteDataSource.fetchCitiesRequest(locationName: locationName);
    listOfCities = List.from(response).map((e) => CityModel.fromJson(e).toEntity()).toList();
    return listOfCities;
  }

  @override
  Future<WeatherEntity> fetchCurrentWeatherRequest({required CityEntity city}) async{
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferences sharedPreferences = locator<SharedPreferences>();
    WeatherEntity currentWeather = const WeatherEntity();

   // final response = await _remoteDataSource.fetchCurrentWeatherRequest(city: city.toModel());
   // currentWeather = WeatherModel.fromJson(response).toEntity();
   // return currentWeather;
    bool isConnected = await hasInternetConnection();
    if (isConnected) {
      // fetch from remote
      final response = await _remoteDataSource.fetchCurrentWeatherRequest(city: city.toModel());
      currentWeather = WeatherModel.fromJson(response).toEntity();

      if (currentWeather.dateTime != null) {
        // clear current weather
        await sharedPreferences.setString(Constants.currentWeatherKey, "");

        // insert current weather to local storage
        await _localDataSource.saveCurrentWeather(weatherResponse: response);
      }
    }

    // fetch from local storage
    final response = await _localDataSource.getCurrentWeather();
    currentWeather = WeatherModel.fromJson(response).toEntity();
    return currentWeather;
  }

  @override
  Future<List<WeatherEntity>> fetchPredictedWeatherRequest({required CityEntity city, required int days}) async{
    // List<WeatherEntity> predictedWeatherList = [];
    // final response = await _remoteDataSource.fetchPredictedWeatherRequest(city: city.toModel(), days: days);
    // predictedWeatherList = List.from(response['list']).map((e) => WeatherModel.fromJson(e).toEntity()).toList();
    // return predictedWeatherList;

    SharedPreferences sharedPreferences = locator<SharedPreferences>();
    List<WeatherEntity> predictedWeatherList = [];

    bool isConnected = await hasInternetConnection();
    if (isConnected) {
      // fetch from remote
      final response = await _remoteDataSource.fetchPredictedWeatherRequest(city: city.toModel(), days: days);
      predictedWeatherList = List.from(response['list']).map((e) => WeatherModel.fromJson(e).toEntity()).toList();

      if (predictedWeatherList.isNotEmpty) {
        // clear weather predictions
        await sharedPreferences.setString(Constants.predictedWeatherKey, "");

        // insert weather predictions to local storage
        await _localDataSource.savePredictedWeather(weatherResponse: response);
      }
    }

    // fetch from local storage
    final response = await _localDataSource.getPredictedWeather();
    predictedWeatherList = List.from(response['list']).map((e) => WeatherModel.fromJson(e).toEntity()).toList();
    return predictedWeatherList;
  }


}