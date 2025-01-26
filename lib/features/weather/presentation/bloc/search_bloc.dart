import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../weather_barrel.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FetchCityListUseCase _useCase;

  SearchBloc({required FetchCityListUseCase useCase}) : _useCase = useCase, super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
