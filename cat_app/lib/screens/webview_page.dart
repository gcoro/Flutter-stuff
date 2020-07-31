import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  WebviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  bool _loading = true;

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
      body: LoadingOverlay(
          child: Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl: 'https://catflix.cl/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                setState(() {
                  _loading = false;
                });
              },
              // TODO(iskakaushik): Remove this when collection literals makes it to stable.
              // ignore: prefer_collection_literals
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
              gestureNavigationEnabled: true,
            );
          }),
          isLoading: _loading,
          color: Colors.pink[200]),
    );
  }
}
