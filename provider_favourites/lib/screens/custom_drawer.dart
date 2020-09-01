import 'package:flutter/material.dart';
import 'package:provider_favourites/services/navigation_service.dart';
import 'package:provider_favourites/constants/route_paths.dart' as routes;

import '../locator.dart';

class CustomDrawer extends StatelessWidget {

  final NavigationService _navigationService = locator<NavigationService>();

  CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("User name", style: Theme.of(context).textTheme.headline1),
              // accountEmail: Text("test2911@gmail.com", style: Theme.of(context).textTheme.bodyText1,),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                child: Text(
                  "A",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            ListTile(
              title: Text('Catalogue', style: Theme.of(context).textTheme.bodyText1),
              onTap: () {
                Navigator.pop(context);
                // Update the state of the app
                _navigationService.navigateTo(routes.CatalogueRoute);
              },
            ),
            ListTile(
              title: Text('Favourites', style: Theme.of(context).textTheme.bodyText1),
              onTap: () {
                Navigator.pop(context);
                // Update the state of the app
                _navigationService.navigateTo(routes.FavouritesRoute);
              },
            ),
            ListTile(
              title: Text('Logout', style: Theme.of(context).textTheme.bodyText1),
              onTap: () {
                // close the drawer
                Navigator.pop(context);
                // Update the state of the app
                _navigationService.navigateTo(routes.LoginRoute);
              },

            ),
          ],
        ),
    );
  }
}