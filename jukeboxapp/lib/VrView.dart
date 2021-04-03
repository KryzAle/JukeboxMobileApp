import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:jukeboxapp/screens/testFinal.dart';

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
  bool _mostrarBoton = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: WillPopScope(
        onWillPop: () {},
        child: Stack(
          children: <Widget>[
            UnityWidget(
              onUnityCreated: onUnityCreated,
              onUnityMessage: onUnityMessage,
              onUnitySceneLoaded: onUnitySceneLoaded,
              isARScene: true,
              fullscreen: true,
            ),
            !_mostrarBoton
                ? Positioned(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.black,
                      width: 20.0,
                      height: 20.0,
                    ),
                  )
                : Positioned(
                    left: 5.0,
                    child:
                        /*ElevatedButton.icon(
                        label: Text('Iniciar'),
                        icon: Icon(Icons.play_arrow_outlined),
                        onPressed: () {
                          cambiarCancion(widget.urlMp3);
                        },
                      ),*/
                        ClipOval(
                      child: Material(
                        color: Colors.red, // button color
                        child: InkWell(
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.play_arrow_rounded)),
                          onTap: () {
                            cambiarCancion(widget.urlMp3);
                            ocultarBoton();
                          },
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  void ocultarBoton() {
    setState(() {
      _mostrarBoton = !_mostrarBoton;
    });
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
    Navigator.pushReplacementNamed(context, 'postVRPhoto');
    //_unityWidgetController.quit(silent: true);
    //_unityWidgetController.dispose();
    //_unityWidgetController.unload();
  }
}
