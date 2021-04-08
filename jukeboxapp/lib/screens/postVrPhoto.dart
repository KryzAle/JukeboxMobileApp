import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:jukeboxapp/services/emociones_provider.dart';

import 'camera.dart';

class PostVRPhoto extends StatefulWidget {
  PostVRPhoto({Key key}) : super(key: key);

  @override
  _PostVRPhotoState createState() => _PostVRPhotoState();
}

class _PostVRPhotoState extends State<PostVRPhoto> {
  File foto;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _crearBody(),
      ),
    );
  }

  Widget _crearBody() {
    return Column(
      children: [
        Center(
          child: Image(
            image: AssetImage(
              'assets/animations/selfie2.gif',
            ),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Queremos evaluar como te sientes",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 22.0,
          ),
        ),
        Text(
          "¿Te tomarías otra Selfie?",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.green[600],
            fontSize: 22.0,
          ),
        ),
        Expanded(child: Container()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          width: double.infinity,
          child: ElevatedButton(
            child: Text("Continuar"),
            onPressed: () => _tomarFoto(),
            style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[300],
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(15),
                textStyle: TextStyle(fontSize: 17.0),
                animationDuration: Duration(minutes: 3)),
          ),
        )
      ],
    );
  }


  _tomarFoto() async {
    final api = EmocionesProvider();
    try {
      final cameras = await availableCameras();
    CameraDescription camera = cameras.firstWhere((description) =>
        description.lensDirection == CameraLensDirection.front);

    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CameraPage(camera: camera)));
      if (result != null) {
         _mostrarDialog();
          foto = File(result);
          await api.getEmociones(foto);
          Navigator.popUntil(context, ModalRoute.withName("menu"));
      } 
    } catch (e) {
      print(e);
      Navigator.pop(context);
      _mostrarDialogError();
    }

    
   
  }

  void _mostrarDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Procesando...",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          );
        });
  }

  void _mostrarDialogError() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No se ha podido procesar"),
            content: Text(
              "Asegurate que tu rostro se vea claramente en la cámara",
            ),
          );
        });
  }
}
