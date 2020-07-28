import 'package:flutter/material.dart';
import 'package:inherited_state_app/state_container.dart';

class UpdateUserScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> firstNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> lastNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> emailKey =
  new GlobalKey<FormFieldState<String>>();

  const UpdateUserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // reference to the state
    final container = StateContainer.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit User Info'),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          autovalidate: false,
          child: new ListView(
            children: [
              new TextFormField(
                key: firstNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              new TextFormField(
                key: lastNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              new TextFormField(
                key: emailKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Email Address',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            var firstName = firstNameKey.currentState.value;
            var lastName = lastNameKey.currentState.value;
            var email = emailKey.currentState.value;

            // This is a hack that prevents
            // The store from overriding user info
            // with an empty string if you only want
            // to change a single attributes
            if (firstName == '') {
              firstName = null;
            }
            if (lastName == '') {
              lastName = null;
            }
            if (email == '') {
              email = null;
            }

            // You can call the method from your store,
            // which will call set state and rerender
            // the widgets that rely on the user slice of state.
            // In this case, thats the home page
            container.updateUserInfo(
              firstName: firstName,
              lastName: lastName,
              email: email,
            );

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}