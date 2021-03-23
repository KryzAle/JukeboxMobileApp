import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukeboxapp/screens/ytSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class TestInicial extends StatefulWidget {
  TestInicial({Key key}) : super(key: key);

  @override
  _TestInicialState createState() => _TestInicialState();
}

class _TestInicialState extends State<TestInicial> {
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
          print("formulario completado, token guardado");
          _tokenFormulario("formulariocompletado");
          Navigator.popAndPushNamed(context,"tomar_foto");
        }
      },
    );
  }

  _tokenFormulario(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
