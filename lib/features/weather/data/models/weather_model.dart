import '../../weather_barrel.dart';

class WeatherModel extends WeatherEntity{

  const WeatherModel({String? dateTime, List<Weather>? listOfWeather, Main? main, String? visibility, Wind? wind, Cloud? cloud, Rain? rain}) :
        super(dateTime: dateTime, listOfWeather: listOfWeather, main: main, visibility: visibility, wind: wind, cloud: cloud, rain: rain);

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      dateTime: "${json['dt']}",
      listOfWeather: json['weather'] != null ? List.from(json['weather']).map((e) => WeatherM.fromJson(e)).toList() : [],
      main: json['main'] != null ? MainM.fromJson(json['main']) : const MainM(),
      visibility: "${json['visibility']}",
      wind: json['wind'] != null ? WindM.fromJson(json['wind']) : const WindM(),
      cloud: json['clouds'] != null ? CloudM.fromJson(json['clouds']) : const CloudM(),
      rain: json['rain'] != null ? RainM.fromJson(json['rain']) : const RainM()
    );
  }
}

class WeatherM extends Weather{
  const WeatherM({String? id, String? main, String? description, String? icon}) : super(id: id, main: main, description: description, icon: icon);

  factory WeatherM.fromJson(Map<String, dynamic> json){
    return WeatherM(
      id: "${json['id']}",
      main: "${json['main']}",
      description: "${json['description']}",
      icon: "${json['icon']}"
    );
  }
}

class MainM extends Main{
  const MainM({String? temp, String? feelsLike, String? tempMin, String? tempMax, String? pressure, String? humidity}) : super(temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity);

  factory MainM.fromJson(Map<String, dynamic> json){
    return MainM(
      temp: "${json['temp']}",
      feelsLike: "${json['feels_like']}",
      tempMin: "${json['temp_min']}",
      tempMax: "${json['temp_max']}",
      pressure: "${json['pressure']}",
      humidity: "${json['humidity']}"
    );
  }
}

class WindM extends Wind{
  const WindM({String? speed, String? deg}) : super(speed: speed, deg: deg);

  factory WindM.fromJson(Map<String, dynamic> json){
    return WindM(
      speed: "${json['speed']}",
      deg: "${json['deg']}"
    );
  }
}

class CloudM extends Cloud{
  const CloudM({String? all}) : super(all: all);

  factory CloudM.fromJson(Map<String, dynamic> json){
    return CloudM(
      all: "${json['all']}"
    );
  }
}

class RainM extends Rain{
  const RainM({String? oneHour, String? threeHours}) : super(oneHour: oneHour, threeHours: threeHours);

  factory RainM.fromJson(Map<String, dynamic> json){
    return RainM(
      oneHour: "${json['1h']}",
      threeHours: "${json['3h']}"
    );
  }
}

extension WeatherModelX on WeatherModel{
  WeatherEntity toEntity() => WeatherEntity(dateTime: dateTime, listOfWeather: listOfWeather, main: main, visibility: visibility, wind: wind, cloud: cloud, rain: rain);
}

extension WeatherMX on WeatherM{
  Weather toEntity() => Weather(id: id, main: main, description: description, icon: icon);
}

extension MainMX on MainM{
  Main toEntity() => Main(temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity);
}

extension WindMX on WindM{
  Wind toEntity() => Wind(speed: speed, deg: deg);
}

extension CloudMX on CloudM{
  Cloud toEntity() => Cloud(all: all);
}

extension RainMX on RainM{
  Rain toEntity() => Rain(oneHour: oneHour, threeHours: threeHours);
}
