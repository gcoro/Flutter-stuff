import 'package:get_it/get_it.dart';
import 'package:provider_favourites/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}