import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jukeboxapp/VrView.dart';
import 'package:jukeboxapp/screens/instruccionesVr.dart';
import 'package:jukeboxapp/services/painter.dart';
import 'package:jukeboxapp/services/shape_models.dart';
import 'package:jukeboxapp/services/tutorial_itens.dart';
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
  List<OverlayEntry> entrys = [];
  OverlayState overlayState;
  int count = 0;
  WebViewController _mycontroller;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    initTargets();
    Future.delayed(Duration(microseconds: 200)).then((value) {
      showTutorial(context, itens);
    });
    super.initState();
    // Enable hybrid composition.
  }

  @override
  void dispose() {
    Future.delayed(Duration(microseconds: 200)).then((value) {
      entrys[count].remove();
      count++;
      if (count != entrys.length) {
        overlayState.insert(entrys[count]);
      }
    });
    super.dispose();
  }

  showTutorial(BuildContext context, List<TutorialItens> children) async {
    var size = MediaQuery.of(context).size;
    overlayState = Overlay.of(context);
    children.forEach((element) async {
      var offset = _capturePositionWidget(element.globalKey);
      var sizeWidget = _getSizeWidget(element.globalKey);
      entrys.add(
        OverlayEntry(
          builder: (context) {
            return GestureDetector(
              onTap: element.touchScreen == true
                  ? () {
                      entrys[count].remove();
                      count++;
                      if (count != entrys.length) {
                        overlayState.insert(entrys[count]);
                      }
                    }
                  : () {},
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    CustomPaint(
                      size: size,
                      painter: HolePainter(
                          shapeFocus: element.shapeFocus,
                          dx: offset.dx + (sizeWidget.width / 2),
                          dy: offset.dy + (sizeWidget.height / 2),
                          width: sizeWidget.width,
                          height: sizeWidget.height),
                    ),
                    Positioned(
                      top: element.top,
                      bottom: element.bottom,
                      left: element.left,
                      right: element.right,
                      child: Container(
                        width: size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: element.crossAxisAlignment,
                          mainAxisAlignment: element.mainAxisAlignment,
                          children: [
                            ...element.children,
                            GestureDetector(
                              child: element.widgetNext ??
                                  Text(
                                    "NEXT",
                                    style: TextStyle(color: Colors.white),
                                  ),
                              onTap: () {
                                entrys[count].remove();
                                count++;
                                if (count != entrys.length) {
                                  overlayState.insert(entrys[count]);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    });

    overlayState.insert(entrys[0]);
  }

  static Offset _capturePositionWidget(GlobalKey key) {
    RenderBox renderPosition = key.currentContext.findRenderObject();

    return renderPosition.localToGlobal(Offset.zero);
  }

  static Size _getSizeWidget(GlobalKey key) {
    RenderBox renderSize = key.currentContext.findRenderObject();
    return renderSize.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Selecciona calidad de audio",
          style: TextStyle(color: Colors.black),
        ),
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
                  /*Image.network(
                    widget.imgYoutube,
                  ),*/
                  //Padding(padding: EdgeInsets.only(bottom: 3.0)),
                  /*Text(
                    widget.tituloYoutube,
                    softWrap: true,
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),*/
                  //Padding(padding: EdgeInsets.only(bottom: 1.5)),
                  /*Text(
                    widget.canalYoutube,
                    softWrap: true,
                    style: TextStyle(fontSize: 12.0),
                  ),*/
                  //Padding(padding: EdgeInsets.only(bottom: 3.0)),

                  Container(
                    key: contenedorDownloader,
                    constraints: BoxConstraints.expand(
                      height:
                          Theme.of(context).textTheme.headline4.fontSize * 1.1 +
                              500.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: WebView(
                      onWebViewCreated: (controller) {
                        _controller.complete(controller);

                        _mycontroller = controller;
                      },
                      gestureNavigationEnabled: false,
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: 'https://yt1s.com/youtube-to-mp3/es?q=' +
                          widget.idYoutube,
                      navigationDelegate: (NavigationRequest request) {
                        if (request.url.contains('yt1s.com') ||
                            request.url.contains("file=")) {
                          print('Conexion admitida a $request}');
                          if (request.url.contains("file=")) {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return InstruccionesVR(
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
                        _mycontroller.evaluateJavascript(
                            "document.getElementsByTagName('header')[0].style.display='none';");
                        _mycontroller.evaluateJavascript(
                            "document.getElementsByTagName('h1')[0].style.display='none';");
                        _mycontroller.evaluateJavascript(
                            "document.getElementsByTagName('p')[0].style.display='none';");
                        _mycontroller.evaluateJavascript(
                            "document.querySelector('body > div > div:nth-child(2)').style.display='none';");
                        _mycontroller.evaluateJavascript(
                            "document.querySelector('body > div > div:nth-child(3)').style.display='none';");
                        _mycontroller.evaluateJavascript(
                            "document.querySelector('body > div > div:nth-child(4)').style.display='none';");
                        _mycontroller.evaluateJavascript(
                            "document.getElementsByTagName('footer')[0].style.display='none';");
                        _mycontroller.evaluateJavascript(
                            "document.getElementsByTagName('p')[1].style.display='none';");
                        Future.delayed(Duration(seconds: 2)).then((value) {
                          //_mycontroller.evaluateJavascript("document.querySelector('#search-result > div > div > img').style.display='none';");
                          _mycontroller.evaluateJavascript(
                              "document.getElementById('cnext').style.display='none';");
                          //_mycontroller.evaluateJavascript("document.getElementsByTagName('p')[2].style.display='none';");
                          //_mycontroller.evaluateJavascript("document.getElementsByTagName('h3')[0].style.display='none';");
                          _mycontroller.evaluateJavascript(
                              "document.getElementsByClassName('at-share-btn-elements')[0].style.display='none';");
                        });
                      },
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }

  void initTargets() {
    itens.addAll({
      TutorialItens(
          globalKey: contenedorDownloader,
          touchScreen: true,
          bottom: 20,
          left: 50,
          children: [
            Text(
              //"Seleccione la calidad de audio, una mayor calidad asegura una mejor experiencia pero el tiempo de carga será mayor",
              "Seleccione el boton de descarga para continuar",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 50,
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
    _mycontroller.reload();
    itens.clear();
  }
}
