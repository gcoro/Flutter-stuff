import 'dart:convert';
import 'dart:io';

class ApiService {
  ApiService();

  Future getImageUrl() async {
    // This is how http calls are done in flutter:
    HttpClient http = HttpClient();
    try {
      // Use darts Uri builder
      var uri = Uri.http('shibe.online', '/api/cats');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var imageUrl = json.decode(responseBody)[0];
      // print('imageurl $imageUrl');
      return imageUrl;
    } catch (exception) {
      print(exception);
    }
  }
}
