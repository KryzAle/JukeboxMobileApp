import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
          print("formulario completado");
        }
      },
    );
  }
}
