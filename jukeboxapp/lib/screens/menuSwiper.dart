import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jukeboxapp/services/sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuSwiper extends StatefulWidget {

  MenuSwiper({Key key}) : super(key: key);

  @override
  _MenuSwiperState createState() => _MenuSwiperState();
}

class _MenuSwiperState extends State<MenuSwiper> {
  final soundService = SoundService();

  bool isFinishSesions=false;

  @override
  void initState() { 
    super.initState();
    consultarCumplioSesiones();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.55],
              colors: [
                Colors.lightBlue[50],
                Colors.blue[900],
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      scale: 0.9,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.5,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          soundService.playSound('click');
                          consultarToken().then((value) {
                            if (value) {
                              Navigator.pushNamed(context, 'tomar_foto');
                            } else {
                              Navigator.pushNamed(context, 'testInicial');
                            }
                          });
                        }, 
                        icon: Icon(Icons.play_arrow_outlined), 
                        label: Text(
                          "Iniciar",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.5,
                      child: ElevatedButton.icon(
                        onPressed: isFinishSesions?(){
                          soundService.playSound('click');
                          Navigator.pushNamed(context, "testFinal");
                        }:null,
                        icon: Icon(Icons.assignment_outlined,color: Colors.black87,), 
                        label: Text(
                          "Test Final",
                          style: TextStyle(fontSize: 16,color: Colors.black87),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.5,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.help_outline_outlined,color: Colors.black87),
                        label: Text(
                          "Progreso",
                          style: TextStyle(fontSize: 16,color: Colors.black87),
                        ),
                        onPressed: () {
                          soundService.playSound('click');
                          Navigator.pushNamed(context, "charts");
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                      ),
                    ),
                    // SizedBox(height: 60),
                    // Btn(
                    //   onTap: () {
                    //     soundService.playSound('click');
                    //   },
                    //   color: Colors.white,
                    //   height: 50,
                    //   width: 50,
                    //   borderRadius: 25,
                    //   child: Icon(Icons.info_outline_rounded),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> consultarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool existe = prefs.containsKey('token');
    return existe;
  }

  Future<void> consultarCumplioSesiones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sesiones = prefs.getInt('sesiones');
    print(sesiones);
    if(sesiones!=null){
      isFinishSesions= sesiones>3?true:false;
    }
    setState(() {
      
    });
  }
}
