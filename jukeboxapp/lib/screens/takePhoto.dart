import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jukeboxapp/services/emociones_provider.dart';

class TakePhoto extends StatefulWidget {
  TakePhoto({Key key}) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File foto;
  final picker = ImagePicker();
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
    await _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final api = EmocionesProvider();
    try {
      final fotoPicker =
          await picker.getImage(source: origen, maxHeight: 864, maxWidth: 1152);
      if (fotoPicker?.path != null) {
        _mostrarDialog();
        foto = File(fotoPicker.path);
        await api.getEmociones(foto);
        setState(() {});
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, "youtube");
      } else {
        foto = null;
      }
      setState(() {});
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
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}
