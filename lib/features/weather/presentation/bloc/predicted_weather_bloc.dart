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
  }

  void _onFetchingPredictedWeather(FetchPredictedWeatherEvent event, Emitter<PredictedWeatherState> emit) async {
    try {
      emit(PredictedWeatherLoading());
      final predictedWeather = await _useCase.call(locationName: event.locationName, days: event.days);
      emit(PredictedWeatherLoaded(predictedWeather: predictedWeather));
    } on DioException catch (e) {
      emit(PredictedWeatherError(message: e.message.toString()));
    } catch (e) {
      emit(const PredictedWeatherError(message: 'An error occurred'));
    }
  }
}
