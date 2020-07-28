import 'package:flutter/material.dart';
import 'package:inherited_state_app/home_screen.dart';
import 'package:inherited_state_app/state_container.dart';

void main() {
  // wrapping the app in the state container let you access the state all over the app
  runApp(new StateContainer(child: new UserApp()));
}

class UserApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new HomeScreen()
    );
  }
}
