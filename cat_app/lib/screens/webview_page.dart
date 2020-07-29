import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void WebViewCreatedCallback(WebViewController controller);

class WebviewPage extends StatefulWidget {
  WebviewPage({Key key, this.title, this.onWebViewCreated}) : super(key: key);

  final String title;
  final WebViewCreatedCallback onWebViewCreated;

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    var content;

    if (defaultTargetPlatform == TargetPlatform.android) {
      print('android device');

      content = AndroidView(
        viewType: 'webview',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      // add other platforms
      content = Text(
          '$defaultTargetPlatform is not yet supported by the map view plugin');
    }

    return Scaffold(
      /// App bar has a ton of functionality, but for now lets
      /// just give it a color and a title.
      appBar: AppBar(

          /// Access this widgets properties with 'widget'
          title: Text(widget.title),
          backgroundColor: Colors.black87),

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
          child: content),
    );
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onWebViewCreated == null) {
      return;
    }
    var controller = new WebViewController(id);
    widget.onWebViewCreated(controller);
    controller.loadUrl('https://catflix.cl/');
  }
}

class WebViewController {
  WebViewController(int id) {
    this._channel = new MethodChannel('webview$id');
  }

  MethodChannel _channel;

  Future<void> loadUrl(String url) async {
    return _channel.invokeMethod('loadUrl', url);
  }
}
