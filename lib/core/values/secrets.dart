import "package:envied/envied.dart";
import "package:flutter/foundation.dart";

part 'secrets.g.dart';

@Envied(path: 'secrets.env')
abstract class Secrets {

  /// OPEN WEATHER API  KEY
  @EnviedField(varName: 'WEATHER_API_KEY', defaultValue: '', obfuscate: true)
  static final String weatherApiKey = _Secrets.weatherApiKey;
}
