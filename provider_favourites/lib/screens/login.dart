// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_favourites/locator.dart';
import 'package:provider_favourites/models/user_model.dart';
import 'package:provider_favourites/services/dialog_service.dart';
import 'package:provider_favourites/services/navigation_service.dart';
import 'package:provider_favourites/constants/route_paths.dart' as routes;

class MyLogin extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  // One TextEditingController for each form input:
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future showDialogInvalidCredentials() async {
    var dialogResult = await _dialogService.showDialog(
        title: 'Error',
        description: 'Invalid credentials');
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
                      Provider.of<User>(context, listen: false).setUser(usernameController.text, emailController.text);
                      _navigationService.navigateToReplace(
                          routes.CatalogueRoute);
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