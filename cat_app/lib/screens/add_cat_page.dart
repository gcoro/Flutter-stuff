import 'package:cat_app/models/cat.dart';
import 'package:flutter/material.dart';

class AddCatPage extends StatefulWidget {
  @override
  _AddCatPageState createState() => _AddCatPageState();
}

class _AddCatPageState extends State<AddCatPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // One TextEditingController for each form input:
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  // You'll need the context in order for the Navigator to work.
  void submitForm(BuildContext context) {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      var newCat = Cat(nameController.text, locationController.text,
          descriptionController.text);
      // Pop the page off the route stack and pass the new
      // dog back to wherever this page was created.
      Navigator.of(context).pop(newCat);
    } else {
      print('Inputs invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add a cat'),
          backgroundColor: Colors.black87,
        ),
        body: Container(
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 32.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  // Text Field is the basic input widget for Flutter.
                  // It comes built in with a ton of great UI and
                  // functionality, such as the labelText field you see below.
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter location';
                        }
                        return null;
                      },
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: "Location",
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Other relevant stuff',
                    ),
                  ),
                ),
                // A Strange situation.
                // A piece of the app that you'll add in the next
                // section *needs* to know its context,
                // and the easiest way to pass a context is to
                // use a builder method. So I've wrapped
                // this button in a Builder as a sort of 'hack'.
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      // The basic Material Design action button.
                      return RaisedButton(
                        // If onPressed is null, the button is disabled
                        // this is my goto temporary callback.
                        onPressed: () => submitForm(context),
                        color: Colors.pinkAccent,
                        child: Text('Submit'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}