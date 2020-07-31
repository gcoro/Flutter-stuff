import 'package:cat_app/services/api_service.dart';
import 'package:cat_app/widgets/bouncing_animation.dart';
import 'package:cat_app/widgets/pulsing_animation.dart';
import 'package:cat_app/widgets/sliding_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class QrScanningPage extends StatefulWidget {
  QrScanningPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QrScanningPageState createState() => _QrScanningPageState();
}

class _QrScanningPageState extends State<QrScanningPage> {
  final api = ApiService();

  bool _loading = false;
  String _scanResult;

  _startScanning() async {
    setState(() {
      _loading = true;
    });

    String cameraScanResult = await scanner.scan();

    setState(() {
      _scanResult = cameraScanResult;
      _loading = false;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _isURL(String url) {
    var urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var match = RegExp(urlPattern, caseSensitive: false).hasMatch(url);
    return match;
  }

  @override
  void initState() {
    super.initState();
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
          actions: <Widget>[],
        ),

        /// Container is a convenience widget that lets us style it's
        /// children. It doesn't take up any space itself, so it
        /// can be used as a placeholder in your code.
        body: LoadingOverlay(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
              child: ListView(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "\nPress button to scan QRCode\n",
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () => _startScanning(),
                        child: Text('SCAN QR CODE'),
                        color: Colors.pinkAccent,
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        child: Column(
                          children: <Widget>[
                            _scanResult != null
                                ? Text(
                                    "THE QR CODE SAYS:\n",
                                    style: TextStyle(fontSize: 20.0),
                                    textAlign: TextAlign.center,
                                  )
                                : Container(),
                            _scanResult != null
                                ? _isURL(_scanResult)
                                    ? RichText(
                                        text: TextSpan(
                                            text: _scanResult + '\n',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(_scanResult);
                                              }),
                                      )
                                    : Text(
                                        _scanResult,
                                        style: TextStyle(fontSize: 20.0),
                                        textAlign: TextAlign.center,
                                      )
                                : Container(),
                          ],
                        )),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "\nTap images to animate\n",
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center,
                      )),
                  SlidingAnimation(),
                  PulsingAnimation(),
                  BouncingAnimation()
                ],
              )),
          isLoading: _loading,
          color: Colors.pink[200],
        ));
  }
}
