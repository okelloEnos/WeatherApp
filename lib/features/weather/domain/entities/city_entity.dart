import 'package:equatable/equatable.dart';
import 'package:weather_app/features/features_barrel.dart';

class CityEntity extends Equatable{
  final String? name;
  final String? country;
  final String? state;
  final double? latitude;
  final double? longitude;

  const CityEntity({this.name, this.country, this.latitude, this.longitude, this.state});

  @override
  List<Object?> get props => [name, country, latitude, longitude, state];

}

extension CityEntityX on CityEntity{
  CityModel toModel() => CityModel(name: name, country: country, latitude: latitude, longitude: longitude, state: state);
}