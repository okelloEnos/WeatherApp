import 'package:equatable/equatable.dart';

import '../../weather_barrel.dart';

class WeatherEntity extends Equatable{
  final int? dateTime;
  final List<Weather>? listOfWeather;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Cloud? cloud;
  final Rain? rain;

  const WeatherEntity({this.dateTime, this.listOfWeather, this.main, this.visibility, this.wind, this.cloud, this.rain});

  @override
  List<Object?> get props => [dateTime, listOfWeather, main, visibility, wind, cloud, rain];
}

class Weather extends Equatable{
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const Weather({this.id, this.main, this.description, this.icon});

  @override
  List<Object?> get props => [id, main, description, icon];
}

class Main extends Equatable{
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  const Main({this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure, this.humidity});

  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, pressure, humidity];
}

class Wind extends Equatable{
  final double? speed;
  final int? deg;

  const Wind({this.speed, this.deg});

  @override
  List<Object?> get props => [speed, deg];
}

class Cloud extends Equatable{
  final int? all;

  const Cloud({this.all});

  @override
  List<Object?> get props => [all];
}

class Rain extends Equatable{
  final double? oneHour;
  final double? threeHours;

  const Rain({this.oneHour, this.threeHours});

  @override
  List<Object?> get props => [oneHour, threeHours];
}

extension WeatherEntityX on WeatherEntity{
  WeatherModel toModel() => WeatherModel(dateTime: dateTime, listOfWeather: listOfWeather, main: main, visibility: visibility, wind: wind, cloud: cloud, rain: rain);
}