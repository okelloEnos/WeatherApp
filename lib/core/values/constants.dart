class Constants{
  static const String baseUrl = "http://api.openweathermap.org/data/2.5";
  static const Duration connectTimeout = Duration(seconds: 120);
  static const Duration sendTimeout = Duration(seconds: 120);
  static const Duration receiveTimeout = Duration(seconds: 120);

  static var currentWeatherKey = "currentWeather";

  static var predictedWeatherKey = "predictedWeather";

  static var metaDataKey = "metaData";
}