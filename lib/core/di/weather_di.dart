import 'package:get_it/get_it.dart';

import '../../features/weather/weather_barrel.dart';

void invokeWeatherDI({required GetIt locator}) {

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
          () => WeatherRemoteDataSourceImpl(dio: locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
          () => WeatherRepositoryImpl(remoteDataSource: locator()));

  // use case
  locator.registerLazySingleton(() => FetchCurrentWeatherUseCase(repository: locator()));
  locator.registerLazySingleton(() => FetchWeatherPredictionUseCase(repository: locator()));
  locator.registerLazySingleton(() => FetchCityListUseCase(repository: locator()));

  // bloc
  locator.registerFactory(
      () => CurrentWeatherBloc(useCase: locator()));
  locator.registerFactory(
          () => PredictedWeatherBloc(useCase: locator()));
  locator.registerFactory(
          () => SearchBloc(useCase: locator()));


}
