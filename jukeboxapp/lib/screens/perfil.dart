import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final name = TextEditingController();
  final lastname = TextEditingController();
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
          Text("Queremos saber como te llamas",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color:Colors.black,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                ),
                hintText: 'Nombre'
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
            child: TextField(
              controller: lastname,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                ),
                hintText: 'Apellido'
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
            width: double.infinity,
            child: ElevatedButton(
              child: Text("Continuar"),
              onPressed:(){
                _guardarNombre("name",name.text,lastname.text);
                FocusScope.of(context).unfocus();
                Navigator.pushReplacementNamed(context, "menu");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[300],
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(15),
                textStyle: TextStyle(
                  fontSize: 17.0
                ),
                animationDuration: Duration(minutes: 3)
              ),
            ),
          )
        ],
      ),
    );
  }

  _guardarNombre(String key, String name,String lastname) async{
    String fullName = "$name $lastname";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, fullName);
  }
}