import 'package:weather_app/features/features_barrel.dart';

class CityModel extends CityEntity{
  const CityModel({String? name, String? country, String? state, double? latitude, double? longitude}) :
        super(name: name, country: country, state: state, latitude: latitude, longitude: longitude);

  factory CityModel.fromJson(Map<String, dynamic> json){
    return CityModel(
      name: json['name'],
      country: json['country'],
      state: json['state'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'country': country,
      'state': state,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}

extension CityModelX on CityModel{
  CityEntity toEntity() => CityEntity(name: name, country: country, state: state, latitude: latitude, longitude: longitude);
}