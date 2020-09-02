import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_favourites/models/user_model.dart';
import 'package:provider_favourites/services/dialog_service.dart';
import 'package:provider_favourites/services/navigation_service.dart';
import 'package:provider_favourites/constants/route_paths.dart' as routes;

import '../locator.dart';

class CustomDrawer extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future showDialogLogout() async {
    var dialogResult = await _dialogService.showDialog(
        title: 'Warning',
        description: 'Do you really want to logout?');

    if (dialogResult.confirmed) {
      _navigationService.navigateToReplace(routes.LoginRoute);
    } else {
      print('User cancelled the dialog');
    }
  }

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
        Container(
        height: 250,
          child: UserAccountsDrawerHeader(
            margin: EdgeInsets.only(bottom: 10),
            accountName: Text(
              Provider.of<User>(context).name,
              style: Theme.of(context).textTheme.headline1,
            ),
            accountEmail: Text(
              Provider.of<User>(context).email,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              child: Text(
                Provider.of<User>(context).name[0].toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),),
          ListTile(
            title:
                Text('Catalogue', style: Theme.of(context).textTheme.bodyText1),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app
              _navigationService.navigateToReplace(routes.CatalogueRoute);
            },
          ),
          ListTile(
            title: Text('Favourites',
                style: Theme.of(context).textTheme.bodyText1),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app
              _navigationService.navigateToReplace(routes.FavouritesRoute);
            },
          ),
          ListTile(
            title: Text('Logout', style: Theme.of(context).textTheme.bodyText1),
            onTap: () {
              Navigator.pop(context);
              showDialogLogout();
            },
          ),
        ],
      ),
    );
  }
}
