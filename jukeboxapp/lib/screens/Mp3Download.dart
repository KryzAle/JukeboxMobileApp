import 'package:flutter/material.dart';
import 'package:jukeboxapp/VrView.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class Mp3Downloader extends StatefulWidget {
  final String idYoutube;
  final String imgYoutube;
  final String tituloYoutube;
  final String canalYoutube;
  Mp3Downloader(
      {Key key,
      @required this.idYoutube,
      @required this.imgYoutube,
      @required this.tituloYoutube,
      @required this.canalYoutube})
      : super(key: key);

  @override
  _Mp3DownloaderState createState() => _Mp3DownloaderState();
}

class _Mp3DownloaderState extends State<Mp3Downloader> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();
  GlobalKey keyButton = GlobalKey();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    initTargets();
    showTutorial();
    super.initState();
    // Enable hybrid composition.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecciona calidad de audio"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Image.network(
                      widget.imgYoutube,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 3.0)),
                    Text(
                      widget.tituloYoutube,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 1.5)),
                    Text(
                      widget.canalYoutube,
                      softWrap: true,
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 3.0)),
                    Container(
                      key: keyButton,
                      constraints: BoxConstraints.expand(
                        height: Theme.of(context).textTheme.headline4.fontSize *
                                1.1 +
                            200.0,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: WebView(
                        gestureNavigationEnabled: false,
                        initialUrl:
                            'https://www.yt-download.org/api/button/mp3/' +
                                widget.idYoutube,
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url
                              .startsWith('https://www.yt-download.org/')) {
                            print('Conexion admitida a $request}');
                            if (request.url.contains("/0")) {
                              print("redirigir a vr");
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return VrView(
                                  urlMp3: request.url,
                                );
                              }));
                            }
                            return NavigationDecision.navigate;
                          } else {
                            print(
                                'Conexion bloqueada a la publicidad to $request}');
                            return NavigationDecision.prevent;
                          }
                        },
                        onPageFinished: (String url) {
                          print("termino la carga");
                          print(url);
                        },
                      ),
                    ),
                  ])),
            ],
          )),
    );
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Seleccione calidad de Audio",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Una mayor calidad de audio asegura una mejor experiencia de juego pero el tiempo de carga será mas lento",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.blue,
      textSkip: "Aceptar",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();
  }
}
