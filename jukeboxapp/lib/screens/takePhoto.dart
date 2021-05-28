import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:jukeboxapp/screens/camera.dart';
import 'package:jukeboxapp/services/emociones_provider.dart';

class TakePhoto extends StatefulWidget {
  TakePhoto({Key key}) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File foto;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
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
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Image(
            image: AssetImage(
              'assets/animations/selfie.gif',
            ),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Queremos saber como te sientes",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 22.0,
          ),
        ),
        Text(
          "Hazte un Selfie",
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
          setState(() {});
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "youtube");
          _mostrarDialogSuccess();
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
   void _mostrarDialogSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Exito"),
            content: Text(
              "Tu selfie ha sido analizada correctamente, Elige una cancion para continuar",
            ),
          );
        });
  }
}
