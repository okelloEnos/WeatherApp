import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app/core/page_transition/app_custom_animation_page_builder.dart';
import '../features/features_barrel.dart';
import 'common_widgets/common_widgets_barrel.dart';

/// app route configuration
final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),

    GoRoute(
      path: '/weather_home',
      pageBuilder: (context, state) => pageBuilderWithTransition(
        context: context,
        state: state,
        duration: 500,
        transitionType: PageTransitionType.rightToLeft,
        child: const WeatherHomeScreen(),
      ),
    ),
    GoRoute(
      path: '/weather_detail',
      pageBuilder: (context, state) => pageBuilderWithTransition(
        context: context,
        state: state,
        duration: 500,
        transitionType: PageTransitionType.rightToLeft,
        child: WeatherDetailScreen(weather: state.extra as WeatherEntity,),
      ),
    ),

  ],
  errorBuilder: (context, state) => RoutingErrorPage(
    goRouterState: state,
  ),
);
