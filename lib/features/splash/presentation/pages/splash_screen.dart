import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core_barrel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const MyLottie(
            lottie: 'assets/lottie/weather.json',
            size: Size(400, 400),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: CustomElevatedButton(
              fontWeight: FontWeight.w700,
                textFontSize: 18.0,
                btnText: "Get Started", onPressed: (){
              context.push('/weather_home');
            }),
          ).animate().slideY(begin: 8, end: 0, duration: const Duration(milliseconds: 1200)),
          const SizedBox(height: 64.0,)
        ],
      ),
    );
  }
}
