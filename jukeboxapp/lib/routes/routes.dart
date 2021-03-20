import 'package:flutter/material.dart';
import 'package:jukeboxapp/screens/takePhoto.dart';
import 'package:jukeboxapp/screens/ytSearch.dart';

Map<String,WidgetBuilder> getAplicationRoutes(){
  return <String,WidgetBuilder>{
    'tomar_foto':(BuildContext context) => TakePhoto(),
    'youtube':(BuildContext context) => YtSearch(),

  };
}