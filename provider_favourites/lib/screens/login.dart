import 'package:flutter/material.dart';
import 'package:provider_favourites/locator.dart';
import 'package:provider_favourites/services/dialog_service.dart';
import 'package:provider_favourites/services/navigation_service.dart';
import 'package:provider_favourites/constants/route_paths.dart' as routes;
import 'package:provider_favourites/services/storage_service.dart';

class MyLogin extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final StorageService _storageService = locator<StorageService>();

  // One TextEditingController for each form input:
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future showDialogInvalidCredentials() async {
    await _dialogService.showDialog(
        title: 'Error',
        description: 'Invalid credentials');
  }

  Future storeUser() async {
    _storageService.setUsername(usernameController.text);
    _storageService.setEmail(emailController.text);
    _navigationService.navigateToReplace(
        routes.CatalogueRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline1,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                  controller: usernameController
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mail',
                ),
                controller: emailController,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('ENTER'),
                onPressed: () {
                    if(usernameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      storeUser();
                    } else {
                      showDialogInvalidCredentials();
                    }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}