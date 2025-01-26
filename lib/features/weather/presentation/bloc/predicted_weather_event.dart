part of 'predicted_weather_bloc.dart';

sealed class PredictedWeatherEvent extends Equatable {
  const PredictedWeatherEvent();
}

class FetchPredictedWeatherEvent extends PredictedWeatherEvent {
  final CityEntity city;
  final int days;

  const FetchPredictedWeatherEvent({required this.city, required this.days});

  @override
  List<Object> get props => [city, days];
}
