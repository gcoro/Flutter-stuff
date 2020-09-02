import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final jsonEncoder = JsonEncoder();
  SharedPreferences _sharedPrefs;

  StorageService();

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  setUsername(String username) {
    _sharedPrefs.setString('username', username);
  }

  getUsername()  {
    return _sharedPrefs.getString('username');
  }

  deleteUsername() {
    _sharedPrefs.remove('username');
  }

  setEmail(String email) {
    _sharedPrefs.setString('email', email);
  }

  getEmail() {
    return _sharedPrefs.getString('email');
  }

  deleteEmail() {
    _sharedPrefs.remove('email');
  }
}
