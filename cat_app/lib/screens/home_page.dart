import 'package:cat_app/models/cat.dart';
import 'package:cat_app/screens/add_cat_page.dart';
import 'package:cat_app/services/api_service.dart';
import 'package:cat_app/services/push_notifications.dart';
import 'package:cat_app/services/storage_service.dart';
import 'package:cat_app/widgets/cat_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = StorageService();
  final api = ApiService();

  List<Cat> cats = [];
  bool _loading = false;

  @override
  initState() {
    super.initState();
    _retrieveStoredCats();

    PushNotificationsManager().init();
  }

  Future _retrieveStoredCats() async {
    setState(() {
      _loading = true;
    });

    var storedCats = await storage.getCats();

    print(storedCats);

    if (storedCats != null && storedCats.length > 0) {
      setState(() {
        cats = cats + storedCats;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  Future _deleteStoredCats() async {
    setState(() {
      _loading = true;
    });

    await storage.removeCats();

    setState(() {
      cats = [];
      _loading = false;
    });
  }

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
      // we get an image for the new cate!
      var imageUrl = await api.getImageUrl();
      newCat.imageUrl = imageUrl;

      setState(() {
        cats.insert(0, newCat);
      });

      await storage.storeCats(cats);
    }
  }

  Future<void> _showDeleteCatsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Delete all your cats?'),
                Text('This will make them very sad'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('NO IM SORRY :('),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('YES'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteStoredCats();
              },
            ),
          ],
        );
      },
    );
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
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: _showDeleteCatsDialog,
            )
          ],
        ),

        /// Container is a convenience widget that lets us style it's
        /// children. It doesn't take up any space itself, so it
        /// can be used as a placeholder in your code.
        body: LoadingOverlay(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [
                  0.1,
                  0.5,
                  0.7,
                  0.9
                ],
                    colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Colors.pink[300],
                  Colors.pink[200],
                  Colors.pink[100],
                  Colors.pink[50],
                ])),
            child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: cats.length > 0
                    ? CatList(cats)
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        child: Text(
                          _loading
                              ? ""
                              : "Add your first cat.\n\n “One cat just leads to another.” – Ernest Hemingway",
                          style: TextStyle(fontSize: 25.0),
                        ),
                      )),
          ),
          isLoading: _loading,
          color: Colors.pink[200],
        ));
  }
}
