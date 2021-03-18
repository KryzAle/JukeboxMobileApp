import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:jukeboxapp/screens/testFinal.dart';
import 'package:jukeboxapp/screens/testInicial.dart';
import 'package:jukeboxapp/screens/ytSearch.dart';

/*void main() {
  runApp(MaterialApp(home: UnityDemoScreen()));
}*/

class VrView extends StatefulWidget {
  final String urlMp3;
  VrView({Key key, @required this.urlMp3}) : super(key: key);

  @override
  _VrViewState createState() => _VrViewState();
}

class _VrViewState extends State<VrView> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
          },
          child: Stack(
            children: <Widget>[
              UnityWidget(
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
                onUnitySceneLoaded: onUnitySceneLoaded,
                isARScene: true,
                fullscreen: true,
              ),
              Positioned(
                child: ElevatedButton(
                  onPressed: () {
                    cambiarCancion(widget.urlMp3);
                  },
                  child: Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  void onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }

  void cambiarCancion(String url) {
    _unityWidgetController.postMessage('AudioManager', 'cambiarUrl', url);
    print(url);
  }

  void onUnityMessage(message) {
    print('Me llego de unity: ${message.toString()}');
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TestFinal();
    }));
    //_unityWidgetController.quit(silent: true);
  }
}
