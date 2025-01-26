part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

class FetchCityListEvent extends SearchEvent {
  final String query;

  const FetchCityListEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
