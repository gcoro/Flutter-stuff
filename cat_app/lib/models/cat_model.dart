import 'dart:convert';
import 'dart:io';

class Cat {
  final String name;
  final String location;
  final String description;
  String imageUrl;

  int rating = 0;

  Cat(this.name, this.location, this.description);

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
      print('imageurl $imageUrl');
    } catch (exception) {
      print(exception);
    }
  }
}
