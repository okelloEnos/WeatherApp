part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();
}

final class CurrentWeatherInitial extends CurrentWeatherState {
  @override
  List<Object> get props => [];
}

final class CurrentWeatherLoading extends CurrentWeatherState {
  @override
  List<Object> get props => [];
}

final class CurrentWeatherLoaded extends CurrentWeatherState {
  final WeatherEntity currentWeather;

  const CurrentWeatherLoaded({required this.currentWeather});

  @override
  List<Object> get props => [currentWeather];
}

final class CurrentWeatherError extends CurrentWeatherState {
  final String message;

  const CurrentWeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
