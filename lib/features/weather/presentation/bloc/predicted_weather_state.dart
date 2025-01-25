part of 'predicted_weather_bloc.dart';

sealed class PredictedWeatherState extends Equatable {
  const PredictedWeatherState();
}

final class PredictedWeatherInitial extends PredictedWeatherState {
  @override
  List<Object> get props => [];
}

final class PredictedWeatherLoading extends PredictedWeatherState {
  @override
  List<Object> get props => [];
}

final class PredictedWeatherLoaded extends PredictedWeatherState {
  final List<WeatherEntity> predictedWeather;

  const PredictedWeatherLoaded({required this.predictedWeather});

  @override
  List<Object> get props => [predictedWeather];
}

final class PredictedWeatherError extends PredictedWeatherState {
  final String message;

  const PredictedWeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
