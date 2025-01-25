part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();
}

class FetchCurrentWeatherEvent extends CurrentWeatherEvent {
  final String locationName;

  const FetchCurrentWeatherEvent({required this.locationName});

  @override
  List<Object> get props => [locationName];
}
