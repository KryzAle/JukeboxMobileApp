import 'package:flutter/material.dart';
import 'package:jukeboxapp/VrView.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class Mp3Downloader extends StatefulWidget {
  final String idYoutube;
  Mp3Downloader({Key key, @required this.idYoutube}) : super(key: key);

  @override
  _Mp3DownloaderState createState() => _Mp3DownloaderState();
}

class _Mp3DownloaderState extends State<Mp3Downloader> {
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
          'https://www.yt-download.org/api/button/mp3/' + widget.idYoutube,
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      onPageFinished: (String url) {
        if (url.contains("/0")) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return VrView(
              urlMp3: url,
            );
          }));
        }
      },
    );
  }
}
