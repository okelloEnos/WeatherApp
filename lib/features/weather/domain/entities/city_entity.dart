import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String cityName;
  final String country;
  final double latitude;
  final double longitude;

  const CityEntity(
      {required this.cityName, required this.country, required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [cityName, country, latitude, longitude];

}