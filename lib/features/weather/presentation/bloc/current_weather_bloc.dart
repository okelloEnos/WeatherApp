import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/features_barrel.dart';
import '../../weather_barrel.dart';

part 'current_weather_event.dart';

part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final FetchCurrentWeatherUseCase _useCase;

  CurrentWeatherBloc({required FetchCurrentWeatherUseCase useCase})
      : _useCase = useCase,
        super(CurrentWeatherInitial()) {
    on<FetchCurrentWeatherEvent>(_onFetchingCurrentWeather);

    add(const FetchCurrentWeatherEvent(city:
    CityEntity(
        name: 'Nairobi', country: 'KE', state: 'Nairobi County',
        latitude: -1.30326415, longitude: 36.826384099341595)));
  }

  void _onFetchingCurrentWeather(
      FetchCurrentWeatherEvent event, Emitter<CurrentWeatherState> emit) async {
    try {
      emit(CurrentWeatherLoading());
      final currentWeather =
          await _useCase.call(city: event.city);
      emit(CurrentWeatherLoaded(currentWeather: currentWeather));
    } on DioException catch (e) {
      emit(CurrentWeatherError(message: e.message.toString()));
    } catch (e) {
      emit(const CurrentWeatherError(message: 'An error occurred'));
    }
  }
}
