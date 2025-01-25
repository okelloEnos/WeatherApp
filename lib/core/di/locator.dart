
import 'package:get_it/get_it.dart';

import 'di_barrel.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  await invokeCoreDI(locator: locator);
  invokeWeatherDI(locator: locator);
}
