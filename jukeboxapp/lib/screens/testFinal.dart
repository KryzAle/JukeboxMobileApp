import 'package:flutter/material.dart';
import 'package:jukeboxapp/screens/menuSwiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class TestFinal extends StatefulWidget {
  TestFinal({Key key}) : super(key: key);

  @override
  _TestFinalState createState() => _TestFinalState();
}

class _TestFinalState extends State<TestFinal> {
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Formulario Inicial",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl:
                'https://docs.google.com/forms/d/e/1FAIpQLSeh922cSxO7F7_m-5LHmytKX2KI9H1dhjPmd3kwiMnwozrQ4A/viewform?usp=sf_link',
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            onPageFinished: (String url) {
              
              if (url.contains("formResponse")) {
                _tokenFormulario("formulariocompletado");
                Navigator.popUntil(context, ModalRoute.withName("menu"));
              }else{
                setState(() {
                  isLoading=false;
                });
              }
            },
          ),
          isLoading? Center(child: CircularProgressIndicator(),) : Stack(),
        ],
      ),
    );
  }

  _tokenFormulario(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
