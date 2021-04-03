import 'package:flutter/material.dart';

import '../VrView.dart';

class InstruccionesVR extends StatefulWidget {
  final String urlMp3;
  InstruccionesVR({Key key, @required this.urlMp3}) : super(key: key);

  @override
  _InstruccionesVRState createState() => _InstruccionesVRState();
}

class _InstruccionesVRState extends State<InstruccionesVR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _crearBody(),
    );
  }

  Widget _crearBody() {
    return Column(
      children: [
        Center(
          child: Image(
            image: AssetImage(
              'assets/animations/vrman.gif',
            ),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "¡Casi listo!",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        Text(
          'Estas a un paso de entrar al modo Realidad Virtual',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue[600],
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Al "Entrar en VR" ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        Text(
          'Coloca tu telefono en los visores',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue[600],
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Luego, presiona un botón como este',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        ClipOval(
          child: Material(
            color: Colors.red, // button color
            child: InkWell(
              child: SizedBox(
                  width: 40, height: 40, child: Icon(Icons.play_arrow_rounded)),
              onTap: () {},
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '¡La canción que seleccionaste iniciará en cualquier momento!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.green[600],
            fontSize: 18.0,
          ),
        ),
        Expanded(child: Container()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          width: double.infinity,
          child: ElevatedButton(
            child: Text("Entrar en VR"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return VrView(
                  urlMp3: widget.urlMp3,
                );
              }));
            },
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
}
