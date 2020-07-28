import 'package:flutter/material.dart';
import 'package:inherited_state_app/state_container.dart';
import 'package:inherited_state_app/update_user_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  AppState appState; // class property for the data we need

  // This Widget will display the users info:
  Widget get _userInfo {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // This refers to the user in your store
          new Text("${appState.firstName ?? ""} ${appState.lastName ?? ""}",
              style: new TextStyle(fontSize: 24.0)),
          new Text(appState.email ?? "", style: new TextStyle(fontSize: 24.0)),
        ],
      ),
    );
  }

  Widget get _logInPrompt {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Please add user information',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  // All this method does is bring up the form page.
  void _updateUser(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new UpdateUserScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This is how you access your store. This container
    // is where your properties and methods live
    final container = StateContainer.of(context);

    // set the class's user
    appState = container.appState;

    var body = appState != null ? _userInfo : _logInPrompt;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inherited Widget Test'),
      ),
      body: body,
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _updateUser(context),
        child: new Icon(Icons.edit),
      ),
    );
  }
}