import 'package:flutter/material.dart';
import 'package:jukeboxapp/screens/menuSwiper.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class TestFinal extends StatefulWidget {
  TestFinal({Key key}) : super(key: key);

  @override
  _TestFinalState createState() => _TestFinalState();
}

class _TestFinalState extends State<TestFinal> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
          'https://docs.google.com/forms/d/e/1FAIpQLSeh922cSxO7F7_m-5LHmytKX2KI9H1dhjPmd3kwiMnwozrQ4A/viewform?usp=sf_link',
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      onPageFinished: (String url) {
        if (url.contains("formResponse")) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MenuSwiper();
          }));
        }
      },
    );
  }
}
