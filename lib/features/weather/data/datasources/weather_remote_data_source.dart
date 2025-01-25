import 'package:dio/dio.dart';
import 'package:weather_app/core/values/values_barrel.dart';
import '../../../../core/core_barrel.dart';
import '../../weather_barrel.dart';

abstract class WeatherRemoteDataSource {

  Future<dynamic> fetchCurrentWeatherRequest({required String locationName});

  Future<dynamic> fetchPredictedWeatherRequest({required String locationName, required int days});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio _dio;

  const WeatherRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<dynamic> fetchCurrentWeatherRequest({required String locationName}) async{
    locationName = "London";
    var url = "${Constants.baseUrl}/weather?q=$locationName&appid=${Secrets.weatherApiKey}";

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
  Future<dynamic> fetchPredictedWeatherRequest({required String locationName, required int days}) async{
    locationName = "London";
    var url = "${Constants.baseUrl}/forecast?appid=${Secrets.weatherApiKey}&cnt=$days&q=$locationName";

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