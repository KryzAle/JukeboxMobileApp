import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

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

  void cambiarCancion(String url) {
    _unityWidgetController.postMessage('AudioManager', 'cambiarUrl', url);
    print(url);
  }
}
