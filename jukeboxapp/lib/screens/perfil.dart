import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  //final user = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String usuario;
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Image(image: AssetImage("assets/images/logo.png")),
          Text(
            "Para poder identificarte mejor",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Necesitamos tu correo electrónico institucional",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 50),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          hintText: 'Usuario'),
                      onSaved: (String value) {
                        usuario = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ingrese su usuario';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "@espe.edu.ec",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            width: double.infinity,
            child: ElevatedButton(
              child: Text("Continuar"),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  _guardarUsuario("name", usuario);
                  FocusScope.of(context).unfocus();
                  Navigator.pushReplacementNamed(context, "menu");
                } else {
                  print('Formulario Vacio');
                }
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
      ),
    );
  }

  _guardarUsuario(String key, String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, user);
    prefs.setInt("sesiones", 0);
  }
}
