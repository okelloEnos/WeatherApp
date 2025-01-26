import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../weather_barrel.dart';

part 'predicted_weather_event.dart';
part 'predicted_weather_state.dart';

class PredictedWeatherBloc extends Bloc<PredictedWeatherEvent, PredictedWeatherState> {
  final FetchWeatherPredictionUseCase _useCase;

  PredictedWeatherBloc({required FetchWeatherPredictionUseCase useCase}) : _useCase = useCase, super(PredictedWeatherInitial()) {

    on<FetchPredictedWeatherEvent>(_onFetchingPredictedWeather);

    add(const FetchPredictedWeatherEvent(city: CityEntity(
        name: 'Nairobi', country: 'KE', state: 'Nairobi County',
        latitude: -1.30326415, longitude: 36.826384099341595), days: 5));
  }

  void _onFetchingPredictedWeather(FetchPredictedWeatherEvent event, Emitter<PredictedWeatherState> emit) async {
    try {
      emit(PredictedWeatherLoading());
      final predictedWeather = await _useCase.call(city: event.city, days: event.days);
      emit(PredictedWeatherLoaded(predictedWeather: predictedWeather));
    } on DioException catch (e) {
      emit(PredictedWeatherError(message: e.message.toString()));
    } catch (e) {
      emit(const PredictedWeatherError(message: 'An error occurred'));
    }
  }
}
