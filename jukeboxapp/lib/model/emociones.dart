import 'package:intl/intl.dart';

class Emociones {
  double angry;
  double disgust;
  DateTime fecha;
  double happy;
  double sad;
  double scared;
  double surprised;

  Emociones(
      {this.angry,
      this.disgust,
      this.fecha,
      this.happy,
      this.sad,
      this.scared,
      this.surprised});

  factory Emociones.fromJson(Map<String, dynamic> json) {
    final format = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    final dateParsed = format.parse(json['fecha']);
    double angryEvaluated = (json['angry'] * 100).roundToDouble();
    double disgustEvaluated = (json['disgust'] * 100).roundToDouble();
    double happyEvaluated = (json['happy'] * 100).roundToDouble();
    double sadEvaluated = (json['sad'] * 100).roundToDouble();
    double scaredEvaluated = (json['scared'] * 100).roundToDouble();
    double surprisedEvaluated = (json['surprised'] * 100).roundToDouble();

    if (angryEvaluated == 0.00) {
      angryEvaluated = 101.00;
    }
    if (disgustEvaluated == 0.00) {
      disgustEvaluated = 101.00;
    }
    if (happyEvaluated == 0.00) {
      happyEvaluated = 101.00;
    }
    if (sadEvaluated == 0.00) {
      sadEvaluated = 101.00;
    }
    if (scaredEvaluated == 0.00) {
      scaredEvaluated = 101.00;
    }
    if (surprisedEvaluated == 0.00) {
      surprisedEvaluated = 101.00;
    }
    return Emociones(
      angry: angryEvaluated,
      disgust: disgustEvaluated,
      fecha: dateParsed,
      happy: happyEvaluated,
      sad: sadEvaluated,
      scared: scaredEvaluated,
      surprised: surprisedEvaluated,
    );
  }
}
