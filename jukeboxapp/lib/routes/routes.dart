import 'package:flutter/material.dart';
import 'package:jukeboxapp/screens/controlpage.dart';
import 'package:jukeboxapp/screens/menuSwiper.dart';
import 'package:jukeboxapp/screens/perfil.dart';
import 'package:jukeboxapp/screens/postVrPhoto.dart';
import 'package:jukeboxapp/screens/takePhoto.dart';
import 'package:jukeboxapp/screens/testFinal.dart';
import 'package:jukeboxapp/screens/testInicial.dart';
import 'package:jukeboxapp/screens/ytSearch.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    'tomar_foto': (BuildContext context) => TakePhoto(),
    'youtube': (BuildContext context) => YtSearch(),
    'menu': (BuildContext context) => MenuSwiper(),
    'perfil': (BuildContext context) => PerfilPage(),
    'testInicial': (BuildContext context) => TestInicial(),
    'postVRPhoto': (BuildContext context) => PostVRPhoto(),
    'testFinal': (BuildContext context) => TestFinal(),
    'charts': (BuildContext context) => ControlPage(),
  };
}
