import 'package:cat_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CatFactsPage extends StatefulWidget {
  CatFactsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CatFactsPageState createState() => _CatFactsPageState();
}

class _CatFactsPageState extends State<CatFactsPage> {
  final api = ApiService();

  String fact;
  bool _loading = false;

  Future _getCatFact() async {
    setState(() {
      _loading = true;
    });
    var catFact = await api.getCatFact();

    if (catFact != null) {
      setState(() {
        fact = catFact;
        _loading = false;
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hey'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hello!'),
                Text('Do you really love cats?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('YES I LOVE CATS'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget get getFactButton {
    return Align(
        alignment: Alignment.center,
        child: RaisedButton(
          onPressed: () => _getCatFact(),
          child: Text('Get fact'),
          color: Colors.pinkAccent,
        ));
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
              icon: Icon(Icons.access_alarm),
              onPressed: () => _showMyDialog(),
            )
          ],
        ),

        /// Container is a convenience widget that lets us style it's
        /// children. It doesn't take up any space itself, so it
        /// can be used as a placeholder in your code.
        body: LoadingOverlay(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 32.0),
            decoration: BoxDecoration(
              // This would be a great opportunity to create a custom LinearGradient widget
              // that could be shared throughout the app but I'll leave that to you.
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Colors.pink[300],
                  Colors.pink[200],
                  Colors.pink[100],
                  Colors.pink[50],
                ],
              ),
            ),
            child: ListView(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    child: Text(
                      ' 🐈',
                      style: TextStyle(fontSize: 36.0),
                    ),
                  ),
                ),
                getFactButton,
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    child: Text(
                      fact ?? "",
                      style: TextStyle(fontSize: 22.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading: _loading,
          color: Colors.pink[200],
        ));
  }
}
