import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jukeboxapp/components/btn.dart';
import 'package:jukeboxapp/services/sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuSwiper extends StatelessWidget {
  final soundService = SoundService();

  MenuSwiper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: SafeArea(
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
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 250,
                        child: RaisedButton.icon(
                          icon: Icon(
                            Icons.play_arrow_outlined,
                            size: 30,
                          ),
                          label: Text(
                            "Iniciar",
                            style: TextStyle(fontSize: 16),
                          ),
                          textColor: Colors.black87,
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.deepPurple[300],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: 250,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.assignment_outlined),
                          label: Text(
                            "Tests",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () => soundService.playSound('click'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.cyan[100],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: 250,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.help_outline_outlined),
                          label: Text(
                            "Ayuda",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "charts");
                            soundService.playSound('click');
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.cyan[100],
                        ),
                      ),
                      SizedBox(height: 60),
                      Btn(
                        onTap: () {
                          soundService.playSound('click');
                        },
                        color: Colors.white,
                        height: 50,
                        width: 50,
                        borderRadius: 25,
                        child: Icon(Icons.info_outline_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
}
