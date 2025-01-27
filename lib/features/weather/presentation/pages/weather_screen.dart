import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/functions/functions_barrel.dart';
import 'package:weather_app/core/values/values_barrel.dart';
import 'package:weather_app/features/features_barrel.dart';
import '../../../../core/core_barrel.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  String? cityName = "";
  String? country = "";
  String? cityState = "";
  double? latitude = 0.0;
  double? longitude = 0.0;
  String? lastUpdated = "";
  CityEntity? selectedCity ;

  @override
  Widget build(BuildContext context) {

    if(locator<SharedPreferences>().getString(Constants.metaDataKey) != null){
      var cityMetaInfo = jsonDecode(locator<SharedPreferences>().getString(Constants.metaDataKey)!);
      cityName = cityMetaInfo["name"];
      country = cityMetaInfo["country"];
      cityState = cityMetaInfo["state"];
      latitude = cityMetaInfo["latitude"];
      longitude = cityMetaInfo["longitude"];
      lastUpdated = cityMetaInfo["lastUpdated"];
    }

    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: BlocBuilder<NetworkBloc, NetworkStatus>(
  builder: (context, state) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(text: "Good ${greetingTime()},", fontSize: 18.0, fontWeight: FontWeight.w500),
                          CustomText(text: DateTimeUtils.formattedDateHeader(DateTime.now()), fontSize: 14.0, fontWeight: FontWeight.w300),
                          (lastUpdated?.isNotEmpty ?? false) ? CustomText(text: "(Last Updated On: ${DateTimeUtils.formattedDate(DateTime.parse(lastUpdated!))})", fontSize: 10.0, fontWeight: FontWeight.w300) : const SizedBox.shrink(),
                        ],
                      ),
                      GestureDetector(onTap: () async{
                       selectedCity =  await showCustomSearch<CityEntity?>(
                          context: context,
                          delegate: WeatherSearchDelegate(),
                        );

                       if(selectedCity != null){
                        setState(() {
                          var cityMetaInfo = {
                            "name": selectedCity?.name,
                            "country": selectedCity?.country,
                            "state": selectedCity?.state,
                            "latitude": selectedCity?.latitude,
                            "longitude": selectedCity?.longitude,
                            "lastUpdated": DateTime.now().toIso8601String(),
                          };
                          locator<SharedPreferences>().setString(Constants.metaDataKey, jsonEncode(cityMetaInfo));
                        });
                         context.read<CurrentWeatherBloc>().add(FetchCurrentWeatherEvent(city: selectedCity!));
                         context.read<PredictedWeatherBloc>().add(FetchPredictedWeatherEvent(city: selectedCity!, days: 5));
                       }
                      }, child: Icon(Icons.search, color: theme.colorScheme.onPrimary, size: 32.0,))
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          builder: (context, state) {
           if(state is CurrentWeatherLoaded){
             WeatherEntity weather = state.currentWeather;
         return GestureDetector(
           onTap: (){
             context.push('/weather_detail', extra: const WeatherEntity());
           },
           child: Container(
             padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
             decoration: BoxDecoration(
               color: theme.colorScheme.onPrimary.withOpacity(0.2),
               borderRadius: BorderRadius.circular(8.0),
             ),
             child: Row(
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     const CustomText(text: "Weather", fontSize: 18.0, fontWeight: FontWeight.w500),
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Icon(Icons.location_on_outlined, color: theme.colorScheme.onPrimary.withOpacity(0.6), size: 24.0),
                         CustomText(text: " $cityName", fontSize: 16.0, fontWeight: FontWeight.w300, color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                       ],
                     ),
                     const SizedBox(height: 24.0),
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         CustomText(text: "${weather.main?.temp}\u{00B0}", fontSize: 18.0, fontWeight: FontWeight.w500),
                         CustomText(text: "${weather.listOfWeather?.first.main}, ${weather.listOfWeather?.first.description}", fontSize: 12.0, fontWeight: FontWeight.w200, color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                       ],
                     ),
                   ],
                 ),
                 const Spacer(),
                 // Image.asset("assets/images/weather.png", width: 120.0, height: 120.0),
                 CachedNetworkImage(
                   imageUrl: "https://openweathermap.org/img/wn/${weather.listOfWeather?.first.icon}@4x.png",
                   imageBuilder: (context,
                       imageProvider) =>
                       Container(
                         decoration:
                         BoxDecoration(
                           image:
                           DecorationImage(
                             image:
                             imageProvider,
                             fit: BoxFit.contain,
                           ),
                         ),
                         height: 120,
                         width: 120,
                       ),
                   placeholder:
                       (context, url) =>
                           ShimmerWidget(child: Image.asset("assets/images/weather.png", width: 120.0, height: 120.0)),
                   errorWidget: (context,
                       url, error) =>
                       Image.asset("assets/images/weather.png", width: 120.0, height: 120.0, color: Colors.black.withOpacity(0.08),),
                 ),
                 const Spacer(),
               ],
             ),
           ),
         ).animate().fadeIn(duration: const Duration(milliseconds: 800));
           }
           else if(state is CurrentWeatherError){
          return WeatherErrorWidget(
            size: const Size(150, 150),
            onRetryPressed: (){
              if(selectedCity != null) {
                context.read<CurrentWeatherBloc>().add(
                    FetchCurrentWeatherEvent(city: selectedCity!));
              }
              else{

                context.read<CurrentWeatherBloc>().add(
                    const FetchCurrentWeatherEvent(city: CityEntity(
                        name: 'Nairobi', country: 'KE', state: 'Nairobi County',
                        latitude: -1.30326415, longitude: 36.826384099341595)));
              }
            },
          );
        }
        else {
          return const ShimmerContainer(width: double.infinity, height: 160);
           }

          },
        ),
                  const SizedBox(height: 32.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Forecast", fontSize: 18.0, fontWeight: FontWeight.w600),
                      CustomText(text: "Next 5 days", fontSize: 16.0, fontWeight: FontWeight.w200),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: BlocBuilder<PredictedWeatherBloc, PredictedWeatherState>(
          builder: (context, state) {
        if(state is PredictedWeatherLoaded){
          return GridView.builder(
            itemCount: state.predictedWeather.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 2/1.5,
            ),
            itemBuilder: (context, index) {
              WeatherEntity weather = state.predictedWeather[index];
              return GestureDetector(
                onTap: (){
                  context.push('/weather_detail', extra: const WeatherEntity());
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Friday, April 26
                      weather.dateTime != null ? CustomText(text: DateTimeUtils.formatTimestampForecast(timestamp: int.tryParse(weather.dateTime ?? "") ?? DateTime.now().millisecondsSinceEpoch), fontSize: 12.0, fontWeight: FontWeight.w500) : const SizedBox.shrink(),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(text: "${weather.main?.temp}\u{00B0}", fontSize: 12.0, fontWeight: FontWeight.w500),
                          // SizedBox(width: 2.0),
                          CustomText(text: "${weather.listOfWeather?.first.main}, ${weather.listOfWeather?.first.description}", fontSize: 10.0, fontWeight: FontWeight.w200, color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                          alignment: Alignment.centerRight,
                          child:
                          CachedNetworkImage(
                            imageUrl: "https://openweathermap.org/img/wn/${weather.listOfWeather?.first.icon}@4x.png",
                            imageBuilder: (context,
                                imageProvider) =>
                                Container(
                                  decoration:
                                  BoxDecoration(
                                    image:
                                    DecorationImage(
                                      image:
                                      imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  height: 60,
                                  width: 60,
                                ),
                            placeholder:
                                (context, url) =>
                                ShimmerWidget(child: Image.asset("assets/images/weather.png", width: 60.0, height: 60.0)),
                            errorWidget: (context,
                                url, error) =>
                                Image.asset("assets/images/weather.png", width: 60.0, height: 60.0, color: Colors.black.withOpacity(0.08),),
                          )
                          // Image.asset("assets/images/weather.png", width: 60.0, height: 60.0)
                ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: const Duration(milliseconds: 300)).scale(delay: Duration(milliseconds: 600 * index), duration: const Duration(milliseconds: 300));
            },);
        }
        else if(state is PredictedWeatherError){
          return WeatherErrorWidget(
            onRetryPressed: (){
              if(selectedCity != null) {
                context.read<PredictedWeatherBloc>().add(
                    FetchPredictedWeatherEvent(city: selectedCity!, days: 5));
              }
              else{

                context.read<PredictedWeatherBloc>().add(
                    const FetchPredictedWeatherEvent(city: CityEntity(
                        name: 'Nairobi', country: 'KE', state: 'Nairobi County',
                        latitude: -1.30326415, longitude: 36.826384099341595), days: 5));
              }
            },
          );
        }
        else {
          return GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 2/1.5,
            ),
            itemBuilder: (context, index) {
              return const ShimmerContainer(width: double.infinity, height: 60.0);
            },);
        }
          },
        ),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: state == NetworkStatus.off
              ? Container(
              color: Colors.red,
              child: const Center(child: CustomText(text: "You are offline", fontSize: 16.0, fontWeight: FontWeight.w500)))
              : const SizedBox(),
        ),
      ],
    );
  },
),
    );
  }
}
