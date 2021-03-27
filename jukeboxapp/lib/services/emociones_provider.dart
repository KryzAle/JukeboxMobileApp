import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmocionesProvider {
  String _url = "http://142.93.253.80/emociones";

  Future getEmociones(File image) async {
    final fullName = await _getFullName();
    final bytes = image.readAsBytesSync();
    var request = new http.MultipartRequest("POST", Uri.parse(_url));
    request.files
        .add(http.MultipartFile.fromBytes('file', bytes, filename: "file"));
    request.fields["fullname"] = fullName;
    final streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      final response = await http.Response.fromStream(streamedResponse);
      final body = json.decode(response.body);
      if (body['message'] == "No se a encontrado una emocion") {
        throw ("NO se pudo analizar");
      }
      print(response.body);
    } else {
      throw ("Error");
    }
  }

  Future<String> _getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }
}
