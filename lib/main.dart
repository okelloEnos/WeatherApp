import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core_barrel.dart';
import 'features/features_barrel.dart';

/// Features
/// 1. Current weather
/// 2. 5-day weather forecast
/// 3. User should enter a city name then have access to above 1 and 2
/// 4. Offline Support
/// 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CurrentWeatherBloc>(create: (_) => locator<CurrentWeatherBloc>()),
      BlocProvider<PredictedWeatherBloc>(create: (_) => locator<PredictedWeatherBloc>()),
    ], child: const WeatherAppView());
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.lightTheme(),
      themeMode: ThemeMode.light,
    );
  }
}
