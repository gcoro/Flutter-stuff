import 'package:cat_app/screens/cat_facts_page.dart';
import 'package:cat_app/screens/home_page.dart';
import 'package:cat_app/screens/qr_scanning_page.dart';
import 'package:cat_app/screens/webview_page.dart';
import 'package:flutter/material.dart';

class BottomTabNavigation extends StatefulWidget {
  BottomTabNavigation({Key key}) : super(key: key);

  @override
  _BottomTabNavigationState createState() => _BottomTabNavigationState();
}

class _BottomTabNavigationState extends State<BottomTabNavigation> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(title: "Rate cats"),
    CatFactsPage(title: "Cat Facts"),
    WebviewPage(title: "Watch"),
    QrScanningPage(title: "Other magic things"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Rate'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Learn'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            title: Text('Web'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            title: Text('Etc'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[100],
        onTap: _onItemTapped,
      ),
    );
  }
}
