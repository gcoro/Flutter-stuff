import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _username;
  String _email;

  String get name => _username;
  String get email => _email;

  void setUser(username,email) {
    _username = username;
    _email = email;
    notifyListeners();
  }
}
