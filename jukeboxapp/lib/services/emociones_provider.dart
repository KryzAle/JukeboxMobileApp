import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exif/exif.dart';
import 'package:image/image.dart' as img;

class EmocionesProvider {
  String _url = "http://142.93.253.80/emociones";

  Future getEmociones(File image) async {
    final fullName = await _getFullName();
    File foto = await fixExifRotation(image.path);
    final bytes = foto.readAsBytesSync();
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

  Future<File> fixExifRotation(String imagePath) async {
    final originalFile = File(imagePath);
    List<int> imageBytes = await originalFile.readAsBytes();

    final originalImage = img.decodeImage(imageBytes);

    final height = originalImage.height;
    final width = originalImage.width;

    // Let's check for the image size
    // This will be true also for upside-down photos but it's ok for me
    if (height >= width) {
      // I'm interested in portrait photos so
      // I'll just return here
      return originalFile;
    }

    // We'll use the exif package to read exif data
    // This is map of several exif properties
    // Let's check 'Image Orientation'
    final exifData = await readExifFromBytes(imageBytes);

    img.Image fixedImage;

    if (height < width) {
      if (exifData['Image Orientation'].printable.contains('Horizontal')) {
        fixedImage = img.copyRotate(originalImage, 0);
      } else if (exifData['Image Orientation'].printable.contains('90')) {
        fixedImage = img.copyRotate(originalImage, -90);
      } else if (exifData['Image Orientation'].printable.contains('180')) {
        fixedImage = img.copyRotate(originalImage, 180);
      } else {
        fixedImage = img.copyRotate(originalImage, 0);
      }
    }

    // Here you can select whether you'd like to save it as png
    // or jpg with some compression
    // I choose jpg with 100% quality
    final fixedFile =
        await originalFile.writeAsBytes(img.encodeJpg(fixedImage));

    return fixedFile;
  }

  Future<String> _getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }
}
