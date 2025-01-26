part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();
}

class FetchCurrentWeatherEvent extends CurrentWeatherEvent {
  final CityEntity city;

  const FetchCurrentWeatherEvent({required this.city});

  @override
  List<Object> get props => [city];
}
