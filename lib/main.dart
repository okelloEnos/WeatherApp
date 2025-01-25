import 'package:flutter/material.dart';

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
      BlocProvider(
          create: (_) => LeadsBloc(
              quotesRepository: QuotesRepository(
                  quotesDataProvider: QuotesDataProvider(dio: Dio())),
              leadsRepository: LeadsRepository(
                  leadsDataProvider: LeadsDataProvider(dio: Dio())))),
      BlocProvider(
          create: (_) => CampaignsBloc(
              repository: CampaignsRepository(
                  dataProvider: CampaignsDataProvider(dio: Dio())),
              templatesRepository: TemplatesRepository(
                  dataProvider: TemplateDataProvider(dio: Dio()))
          )),
      BlocProvider(
          create: (_) => TemplatesBloc(
              repository: TemplatesRepository(
                  dataProvider: TemplateDataProvider(dio: Dio())))),
      BlocProvider(
          create: (_) => WorkflowsBloc(
              repository: WorkflowRepository(
                  dataProvider: WorkflowDataProvider(dio: Dio())))),
      BlocProvider(
          create: (_) => QuotesBloc(
              quotesRepository: QuotesRepository(
                  quotesDataProvider: QuotesDataProvider(dio: Dio())))),
      BlocProvider(
          create: (_) => ContactsBloc(
              repository: ContactsRepository(
                  dataProvider: ContactsDataProvider(dio: Dio())))),
      BlocProvider(
          create: (_) => GroupCustomerBloc(
              repository: GroupCustomerRepository(
                  dataProvider: GroupCustomerDataProvider(dio: Dio())),
              leadsRepository: LeadsRepository(
                  leadsDataProvider: LeadsDataProvider(dio: Dio())))),
      BlocProvider(create: (_) => LoginBloc()),
      BlocProvider(create: (_) => SignUpBloc()),
      BlocProvider(create: (_) => ScratchEditorBloc()),
      BlocProvider(create: (_) => StudioDraftsBloc()),
    ], child: const WeatherAppView());
  }
}

class WeatherAppView extends StatefulWidget {
  @override
  State<WeatherAppView> createState() => _WeatherAppViewState();
}

class _WeatherAppViewState extends State<WeatherAppView> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.light,
    );
  }
}
