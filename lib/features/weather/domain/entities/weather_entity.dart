import 'package:equatable/equatable.dart';

import '../../weather_barrel.dart';

class WeatherEntity extends Equatable{
  final String? dateTime;
  final List<Weather>? listOfWeather;
  final Main? main;
  final String? visibility;
  final Wind? wind;
  final Cloud? cloud;
  final Rain? rain;

  const WeatherEntity({this.dateTime, this.listOfWeather, this.main, this.visibility, this.wind, this.cloud, this.rain});

  @override
  List<Object?> get props => [dateTime, listOfWeather, main, visibility, wind, cloud, rain];
}

class Weather extends Equatable{
  final String? id;
  final String? main;
  final String? description;
  final String? icon;

  const Weather({this.id, this.main, this.description, this.icon});

  @override
  List<Object?> get props => [id, main, description, icon];
}

class Main extends Equatable{
  final String? temp;
  final String? feelsLike;
  final String? tempMin;
  final String? tempMax;
  final String? pressure;
  final String? humidity;

  const Main({this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure, this.humidity});

  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, pressure, humidity];
}

class Wind extends Equatable{
  final String? speed;
  final String? deg;

  const Wind({this.speed, this.deg});

  @override
  List<Object?> get props => [speed, deg];
}

class Cloud extends Equatable{
  final String? all;

  const Cloud({this.all});

  @override
  List<Object?> get props => [all];
}

class Rain extends Equatable{
  final String? oneHour;
  final String? threeHours;

  const Rain({this.oneHour, this.threeHours});

  @override
  List<Object?> get props => [oneHour, threeHours];
}

extension WeatherEntityX on WeatherEntity{
  WeatherModel toModel() => WeatherModel(dateTime: dateTime, listOfWeather: listOfWeather, main: main, visibility: visibility, wind: wind, cloud: cloud, rain: rain);
}