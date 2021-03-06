import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_favourites/constants/route_paths.dart' as routes;
import 'package:provider_favourites/managers/dialog_manager.dart';
import 'package:provider_favourites/screens/cart.dart';
import 'package:provider_favourites/screens/catalog.dart';
import 'package:provider_favourites/screens/login.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(
          builder: (context) => DialogManager(child: MyLogin()));
    case routes.CatalogueRoute:
      return MaterialPageRoute(
          builder: (context) => DialogManager(child: MyCatalog()));
    case routes.FavouritesRoute:
      return MaterialPageRoute(
          builder: (context) => DialogManager(child: MyCart()));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
