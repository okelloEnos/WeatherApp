import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/common_widgets/common_widgets_barrel.dart';
import 'package:weather_app/features/features_barrel.dart';

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Padding(
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(text: "Good Morning", fontSize: 18.0, fontWeight: FontWeight.w500),
                      CustomText(text: "Thu, Apr 25 - 06:32 PM", fontSize: 16.0, fontWeight: FontWeight.w300),
                    ],
                  ),
                  GestureDetector(onTap: (){
                    showCustomSearch(
                      context: context,
                      delegate: WeatherSearchDelegate(),
                    );
                  }, child: Icon(Icons.search, color: theme.colorScheme.onPrimary, size: 32.0,))
                ],
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
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
                              CustomText(text: " London", fontSize: 16.0, fontWeight: FontWeight.w300, color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const CustomText(text: "24\u{00B0}", fontSize: 18.0, fontWeight: FontWeight.w500),
                              // SizedBox(width: 2.0),
                              CustomText(text: "Mostly Clear", fontSize: 12.0, fontWeight: FontWeight.w200, color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset("assets/images/weather.png", width: 120.0, height: 120.0),
                      const Spacer(),
                    ],
                  ),
                ),
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
                child: GridView.builder(
                  itemCount: 5,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 2/1.5,
                    ),
                    itemBuilder: (context, index) {
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
                              const CustomText(text: "Friday, April 26", fontSize: 12.0, fontWeight: FontWeight.w500),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const CustomText(text: "24\u{00B0}", fontSize: 12.0, fontWeight: FontWeight.w500),
                                  // SizedBox(width: 2.0),
                                  CustomText(text: "Mostly Clear", fontSize: 10.0, fontWeight: FontWeight.w200, color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset("assets/images/weather.png", width: 60.0, height: 60.0)),
                            ],
                          ),
                        ),
                      );
                    },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
