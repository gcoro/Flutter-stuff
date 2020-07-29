import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
part 'cat.g.dart';

@JsonSerializable()
class Cat {
  Cat(String name, String location, String description,
      [String imageUrl, int rating]) {
    this.name = name;
    this.location = location;
    this.description = description;
    this.imageUrl = imageUrl ?? null;
    this.rating = rating ?? 0;
  }

  String name;
  String location;
  String description;
  String imageUrl;
  int rating;

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);
  Map<String, dynamic> toJson() => _$CatToJson(this);

  Future getImageUrl() async {
    // Null check so our app isn't doing extra work.
    // If there's already an image, we don't need to get one.
    if (imageUrl != null) {
      return;
    }

    // This is how http calls are done in flutter:
    HttpClient http = HttpClient();
    try {
      // Use darts Uri builder
      var uri = Uri.http('shibe.online', '/api/cats');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      imageUrl = json.decode(responseBody)[0];
      // print('imageurl $imageUrl');
    } catch (exception) {
      print(exception);
    }
  }
}
