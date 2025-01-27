import 'package:dio/dio.dart';
import 'package:weather_app/core/values/values_barrel.dart';

import '../../weather_barrel.dart';

abstract class WeatherRemoteDataSource {

  Future<dynamic> fetchCitiesRequest({required String locationName});

  Future<dynamic> fetchCurrentWeatherRequest({required CityModel city});

  Future<dynamic> fetchPredictedWeatherRequest({required CityModel city, required int days});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio _dio;

  const WeatherRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<dynamic> fetchCitiesRequest({required String locationName}) async{
    // locationName = "London";
    var url = "http://api.openweathermap.org/geo/1.0/direct?q=$locationName&appid=${Secrets.weatherApiKey}";

    final response = await _dio.get(url);

    if((response.statusCode ?? 0) == 200){
      final weatherResponse = response.data;

      return weatherResponse;
    }
    else {
      throw("${response.statusMessage}");
    }
  }

  @override
  Future<dynamic> fetchCurrentWeatherRequest({required CityModel city}) async{
    String locationName = "${city.name}";
    double latitude = city.latitude ?? 0.0;
    double longitude = city.longitude ?? 0.0;

    var url = "${Constants.baseUrl}/weather?lat=$latitude&lon=$longitude&units=metric&appid=${Secrets.weatherApiKey}";

    final response = await _dio.get(url);

    if((response.statusCode ?? 0) == 200){
      final weatherResponse = response.data;

      return weatherResponse;
    }
    else {
      throw("${response.statusMessage}");
    }
  }

  @override
  Future<dynamic> fetchPredictedWeatherRequest({required CityModel city, required int days}) async{
    String locationName = "${city.name}";
    double latitude = city.latitude ?? 0.0;
    double longitude = city.longitude ?? 0.0;
    days = 100;

    var url = "${Constants.baseUrl}/forecast?lat=$latitude&lon=$longitude&cnt=$days&units=metric&appid=${Secrets.weatherApiKey}";

    final response = await _dio.get(url);

    if((response.statusCode ?? 0) == 200){
      final weatherResponse = response.data;

      return weatherResponse;
    }
    else {
      throw("${response.statusMessage}");
    }
  }

}