import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../weather_barrel.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FetchCityListUseCase _useCase;

  SearchBloc({required FetchCityListUseCase useCase})
      : _useCase = useCase,
        super(SearchInitial()) {
    on<FetchCityListEvent>(_onFetchingListOfCities);
  }

  void _onFetchingListOfCities(
      FetchCityListEvent event, Emitter<SearchState> emit) async {
    try {
      emit(SearchLoading());
      final cities = await _useCase.call(locationName: event.query);
      emit(SearchLoaded(cities: cities));
    } on DioException catch (e) {
      emit(SearchError(message: e.message ?? "An error occurred"));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
