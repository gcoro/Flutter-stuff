import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_favourites/constants/route_paths.dart' as routes;
import 'package:provider_favourites/screens/cart.dart';
import 'package:provider_favourites/screens/catalog.dart';
import 'package:provider_favourites/screens/login.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => MyLogin());
    case routes.CatalogueRoute:
      return MaterialPageRoute(builder: (context) => MyCatalog());
    case routes.FavouritesRoute:
      return MaterialPageRoute(builder: (context) => MyCart());
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