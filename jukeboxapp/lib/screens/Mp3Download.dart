import 'package:flutter/material.dart';
import 'package:jukeboxapp/VrView.dart';
import 'package:tutorial/tutorial.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

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
  GlobalKey contenedorDownloader = GlobalKey();
  List<TutorialItens> itens = [];
  List<TutorialItens> itensDelete = [];


  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    initTargets();
    showTutorial();
    Future.delayed(Duration(microseconds: 200)).then((value) {
      showTutorial();
    });
    super.initState();
    // Enable hybrid composition.
  }
 @override
 void dispose() {
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("Selecciona calidad de audio",style: TextStyle(color: Colors.black),),
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
                      key: contenedorDownloader,
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
    itens.addAll({
      TutorialItens(
          globalKey: contenedorDownloader,
          touchScreen: true,
          bottom: 50,
          left: 50,
          children: [
            Text(
              "Seleccione la calidad de audio, una mayor calidad asegura una mejor experiencia pero el tiempo de carga será mayor",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 100,
            ),
          ],
          widgetNext: Text(
            "Toque para continuar",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          shapeFocus: ShapeFocus.square),
    });
  }
  void deleteTargets() {
    itens.removeLast();
  }

  void showTutorial() {
    Tutorial.showTutorial(context, itens);
  }
}
