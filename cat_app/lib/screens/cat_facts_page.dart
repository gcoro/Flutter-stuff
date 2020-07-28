import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class CatFactsPage extends StatefulWidget {
  CatFactsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CatFactsPageState createState() => _CatFactsPageState();
}

class _CatFactsPageState extends State<CatFactsPage> {

  String fact;

  Future getCatFact() async {
    // This is how http calls are done in flutter:
    HttpClient http = HttpClient();
    try {
      // Use darts Uri builder
      var uri = Uri.https('catfact.ninja', '/fact');
      var request = await http.getUrl(uri);
      var response = await request.close();
      if(response.statusCode == 200) {
        var responseBody = await response.transform(utf8.decoder).join();
        var res = json.decode(responseBody);
        var catFact = res['fact'];
        print('cat fact $catFact');

        setState(() {
          fact = catFact;
        });
      } else {
        print('error $response.statusCode');
      }

    } catch (exception) {
      print(exception);
    }
  }

  Widget get getFactButton {
    return RaisedButton(
      onPressed: () => getCatFact(),
      child: Text('Get fact'),
      color: Colors.pinkAccent,
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
            icon: Icon(Icons.access_alarm),
            onPressed: null,
          )
        ],
      ),
      /// Container is a convenience widget that lets us style it's
      /// children. It doesn't take up any space itself, so it
      /// can be used as a placeholder in your code.
      body: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Text(
              ' 🐈',
              style: TextStyle(fontSize: 36.0),
            ),
            ),
            getFactButton,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Text(
                fact ?? "Press button to know a really interesting cat fact",
                style: TextStyle(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
