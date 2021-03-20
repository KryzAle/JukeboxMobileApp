import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class EmocionesProvider{
  String _url = "http://143.198.231.36/emociones";

  Future getEmociones(File image) async{
    final bytes = image.readAsBytesSync();
    var request = new http.MultipartRequest("POST", Uri.parse(_url));
    request.files.add(http.MultipartFile.fromBytes('file', bytes,filename: "file"));
    final streamedResponse = await request.send();
    if(streamedResponse.statusCode==200){
      final response = await http.Response.fromStream(streamedResponse);
      final body = json.decode(response.body);
      if(body['message']=="No se a encontrado una emocion"){
        throw("NO se pudo analizar");
      }
      print(response.body);
    }else{
       throw("Error");
    }
  }
}