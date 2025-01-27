import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:weather_app/features/features_barrel.dart';

import '../../../../core/core_barrel.dart';
import '../../../../core/values/constants.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherEntity weather;
  const WeatherDetailScreen({Key? key, required this.weather}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String cityName = "";
    var theme = Theme.of(context);

    if(locator<SharedPreferences>().getString(Constants.metaDataKey) != null){
      var cityMetaInfo = jsonDecode(locator<SharedPreferences>().getString(Constants.metaDataKey)!);
      cityName = cityMetaInfo["name"];
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0.0,
        leading: IconButton(
          icon: const BackButton(),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(text: cityName, fontSize: 24.0, fontWeight: FontWeight.w700),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "${weather.main?.temp}\u{00B0}", fontSize: 42.0, fontWeight: FontWeight.w500),
                      CustomText(text: "${weather.listOfWeather?.first.main}, ${weather.listOfWeather?.first.description}", fontSize: 18.0, fontWeight: FontWeight.w200, color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                    ],
                  ),
                  const Spacer(),
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
                          height: 150,
                          width: 150,
                        ),
                    placeholder:
                        (context, url) =>
                        ShimmerWidget(child: Image.asset("assets/images/weather.png", width: 150.0, height: 1500)),
                    errorWidget: (context,
                        url, error) =>
                        Image.asset("assets/images/weather.png", width: 150.0, height: 150.0, color: Colors.black.withOpacity(0.08),),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              CustomText(text: "${weather.main?.tempMin}\u{00B0}/${weather.main?.tempMax}\u{00B0}  Feels Like ${weather.main?.feelsLike}\u{00B0}", fontSize: 14.0, fontWeight: FontWeight.w500),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 8.0),
             child: Divider(
               color: theme.colorScheme.onPrimary.withOpacity(0.2),
             ),
           ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
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
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/humidity.png", width: 24.0, height: 24.0, color: theme.colorScheme.onPrimary,),
                              const SizedBox(width: 6.0),
                              const CustomText(text: "Humidity", fontSize: 12.0, fontWeight: FontWeight.w600),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          CustomText(text: "${weather.main?.humidity}%", fontSize: 16.0, fontWeight: FontWeight.w500),
                          const SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(
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
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/pressure.png", width: 24.0, height: 24.0, color: theme.colorScheme.onPrimary,),
                              const SizedBox(width: 6.0),
                              const CustomText(text: "Pressure", fontSize: 12.0, fontWeight: FontWeight.w600),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          CustomText(text: "${weather.main?.pressure}hPa", fontSize: 16.0, fontWeight: FontWeight.w500),
                          const SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0,),
              Row(
                children: [
                  Expanded(
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
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/wind.png", width: 24.0, height: 24.0, color: theme.colorScheme.onPrimary,),
                              const SizedBox(width: 6.0),
                              const CustomText(text: "Wind", fontSize: 12.0, fontWeight: FontWeight.w600),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          CustomText(text: "${weather.wind?.speed}m/s", fontSize: 16.0, fontWeight: FontWeight.w500),
                          const SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(
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
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/cloud.png", width: 24.0, height: 24.0, color: theme.colorScheme.onPrimary,),
                              const SizedBox(width: 6.0),
                              const CustomText(text: "Cloud", fontSize: 12.0, fontWeight: FontWeight.w600),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          CustomText(text: "${weather.cloud?.all}%", fontSize: 16.0, fontWeight: FontWeight.w500),
                          const SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ).animate().fadeIn(duration: const Duration(milliseconds: 400)).scale(duration: const Duration(milliseconds: 600)),
    );
  }
}
