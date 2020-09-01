import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This class is what Provider will work with.
// It will _provide_ an instance of the class to any widget
// in the tree that cares about it.
class Person with ChangeNotifier {
  Person({this.name, this.age});

  final String name;
  int age;

  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}

// Here, we are running an app as you'd expect with any Flutter app
// But, we're also wrapping `MyApp` in a widget called 'Provider'
// Importantly, `Provider` is itself a widget, so it can live in the widget tree.
// This class uses a property called `create` to make an instance of `Person`
// whenever it's needed by a widget in the tree.
// The object returned by the function passed to `create` is what the rest of our app
// has access to.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Person(name: "Yohan", age: 25),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

// Again, just a stateless widget
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Person>(
      builder: (context, person, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Provider Class'),
          ),
          body: Center(
            child: Text(
              // this string is where we use Provider to fetch the instance
              // of `Person` created above in the `create` property
              '''Hi ${person.name}!\nYou are ${person.age} years old''',
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            // this is where there's a difference.
            // when the FAB is tapped, it will call `Person.increaseAge()` on the
            // person instance that was created by provider.
            onPressed: () => Provider.of<Person>(context, listen: false).increaseAge(),
          ),
        );
      },
    );
  }
}

