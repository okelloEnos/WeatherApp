part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoaded extends SearchState {
  final List<CityEntity> cities;

  const SearchLoaded({required this.cities});

  @override
  List<Object> get props => [cities];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
