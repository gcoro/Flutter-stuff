import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_favourites/locator.dart';
import 'package:provider_favourites/services/navigation_service.dart';
import 'package:provider_favourites/router.dart' as router;
import 'package:provider_favourites/constants/route_paths.dart' as routes;
import 'common/theme.dart';
import 'models/cart.model.dart';
import 'models/catalog.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: appTheme,
        onGenerateRoute: router.generateRoute,
        initialRoute: routes.LoginRoute,
      ),
    );
  }
}
