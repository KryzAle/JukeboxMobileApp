import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

/*void main() {
  runApp(MaterialApp(home: UnityDemoScreen()));
}*/

class UnityDemoScreen extends StatefulWidget {
  UnityDemoScreen({Key key}) : super(key: key);

  @override
  _UnityDemoScreenState createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen> {
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
            // Pop the category page if Android back button is pressed.
          },
          child: Stack(
            children: <Widget>[
              UnityWidget(
                onUnityCreated: onUnityCreated,
                isARScene: true,
              ),
              Positioned(
                child: ElevatedButton(
                  onPressed: () {
                    cambiarCancion(
                        "https://dl20.freemp3downloads.online/file/youtubeNWMRx4G9zjo128.mp3?fn=EL%20CUARTETO%20DE%20IBAI%20(Versi%C3%B3n%20Oficial)%20ft.%20Lucas%20Requena%20%26%20ortoPilot.mp3");
                  },
                  child: Text('Iniciar'),
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

  void cambiarCancion(String url) {
    _unityWidgetController.postMessage('AudioManager', 'cambiarUrl', url);
    print(url);
  }
}
