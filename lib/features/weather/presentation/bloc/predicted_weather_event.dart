part of 'predicted_weather_bloc.dart';

sealed class PredictedWeatherEvent extends Equatable {
  const PredictedWeatherEvent();
}

class FetchPredictedWeatherEvent extends PredictedWeatherEvent {
  final String locationName;
  final int days;

  const FetchPredictedWeatherEvent({required this.locationName, required this.days});

  @override
  List<Object> get props => [locationName, days];
}
