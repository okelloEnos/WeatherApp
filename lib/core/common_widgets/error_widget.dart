
import 'package:flutter/material.dart';

import '../core_barrel.dart';

class WeatherErrorWidget extends StatelessWidget {
final Size? size;
  final VoidCallback? onRetryPressed;
  const WeatherErrorWidget({super.key, this.onRetryPressed, this.size});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyLottie(lottie: "assets/lottie/error-fetching.json", size: size ?? const Size(250, 250)),
          Center(
              child: CustomText(
                  text: "Error Fetching Data",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.tertiary)),
          const SizedBox(
            height: 8.0,
          ),
          Center(
              child: CustomText(
                  text: "We encountered an error while retrieving your data. Please try again later.",
                  textAlign: TextAlign.center,
                  fontSize: 12,
                  color: theme.colorScheme.tertiary)),
          const SizedBox(
            height: 16.0,
          ),
          CustomElevatedButton(
            btnSize: const Size(150, 40),
              radius: 100.0,
              btnText: "Try Again", onPressed: onRetryPressed),
          const SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }
}