import 'package:cat_app/models/cat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  final jsonEncoder = JsonEncoder();

  StorageService();

  storeCats(List<Cat> cats) async {
    final prefs = await SharedPreferences.getInstance();
    var stringifiedCats = jsonEncoder.convert(cats);
    // print(stringifiedCats);
    prefs.setString('cats', stringifiedCats);
  }

  getCats() async {
    final prefs = await SharedPreferences.getInstance();
    var stringifiedCats = prefs.getString('cats');
    print(stringifiedCats);
    var cats = [];
    if (stringifiedCats != null) {
      cats =(json.decode(stringifiedCats) as List).map((i) =>
              Cat.fromJson(i)).toList();
    }
    return cats;
  }
}
