import 'package:cat_app/models/cat_model.dart';
import 'package:cat_app/screens/add_cat_page.dart';
import 'package:cat_app/widgets/cat_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cat> cats = [
    Cat('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch. No: Dogs who get on furniture.'),
    Cat('Rex', 'Seattle, WA, USA', 'Best in Show 1999'),
    Cat('Rod', 'Prague, CZ',
        'Star good boy on international snooze team.'),
    Cat('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'),
    Cat('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.')
  ];

    // Any time you're pushing a new route and expect that route
  // to return something back to you,
  // you need to use an async function.
  // In this case, the function will create a form page
  // which the user can fill out and submit.
  // On submission, the information in that form page
  // will be passed back to this function.
    Future _showAddCatForm() async {
    // push a new route like you did in the last section
    Cat newCat = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddCatPage();
        },
      ),
    );

    // A null check, to make sure that the user didn't abandon the form.
    if (newCat != null) {
      // Add a newDog to our mock dog array.
      setState(() =>   cats.add(newCat));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Scaffold is the base for a page.
    /// It gives an AppBar for the top,
    /// Space for the main body, bottom navigation, and more.
    return Scaffold(
      /// App bar has a ton of functionality, but for now lets
      /// just give it a color and a title.
      appBar: AppBar(
        /// Access this widgets properties with 'widget'
        title: Text(widget.title),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddCatForm,
          )
        ],
      ),
      /// Container is a convenience widget that lets us style it's
      /// children. It doesn't take up any space itself, so it
      /// can be used as a placeholder in your code.
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.pink[300],
            Colors.pink[200],
            Colors.pink[100],
            Colors.pink[50],
            ]
          )
        ),
        child: CatList(cats),
      ),
    );
  }
}
