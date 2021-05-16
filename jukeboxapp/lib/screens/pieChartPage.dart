import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:io';

import 'package:jukeboxapp/model/emociones.dart';

class PieChartPage extends StatefulWidget {
  final Emociones emocionAntes;
  final Emociones emocionDespues;

  PieChartPage({
    Key key,
    @required this.emocionAntes,
    @required this.emocionDespues,
  }) : super(key: key);
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  int touchedIndex;
  int touchedIndexAfter;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Text(
            "Ultima Sesión",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10.0),
        ),
        Container(
          child: Text(
            "Antes",
            style: TextStyle(fontSize: 14),
          ),
          alignment: Alignment.topRight,
          padding: EdgeInsets.all(10.0),
        ),
        AspectRatio(
          aspectRatio: 1.4,
          child: Card(
            elevation: 0.0,
            color: Colors.white,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        final desiredTouch =
                            pieTouchResponse.touchInput is! PointerExitEvent &&
                                pieTouchResponse.touchInput is! PointerUpEvent;
                        if (desiredTouch &&
                            pieTouchResponse.touchedSection != null) {
                          touchedIndex = pieTouchResponse
                              .touchedSection.touchedSectionIndex;
                        } else {
                          touchedIndex = -1;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSections()),
              ),
            ),
          ),
        ),
        Container(
          child: Text(
            "Despues",
            style: TextStyle(fontSize: 14),
          ),
          alignment: Alignment.topRight,
          padding: EdgeInsets.all(10.0),
        ),
        AspectRatio(
          aspectRatio: 1.4,
          child: Card(
            elevation: 0.0,
            color: Colors.white,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        final desiredTouch =
                            pieTouchResponse.touchInput is! PointerExitEvent &&
                                pieTouchResponse.touchInput is! PointerUpEvent;
                        if (desiredTouch &&
                            pieTouchResponse.touchedSection != null) {
                          touchedIndexAfter = pieTouchResponse
                              .touchedSection.touchedSectionIndex;
                        } else {
                          touchedIndexAfter = -1;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSectionsAfter()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    var list = List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 35 : 30;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: widget.emocionAntes.angry,
            title:
                widget.emocionAntes.angry.toString().replaceAll(".0", "") + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xff0293ee),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/angry.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: widget.emocionAntes.disgust,
            title: widget.emocionAntes.disgust.toString().replaceAll(".0", "") +
                "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xfff8b250),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/disgust.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: widget.emocionAntes.happy,
            title:
                widget.emocionAntes.happy.toString().replaceAll(".0", "") + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xff845bef),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/happy.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: widget.emocionAntes.sad,
            title:
                widget.emocionAntes.sad.toString().replaceAll(".0", "") + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xff13d38e),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/sad.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Colors.red,
            value: widget.emocionAntes.scared,
            title: widget.emocionAntes.scared.toString().replaceAll(".0", "") +
                "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/scared.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 5:
          return PieChartSectionData(
            color: Colors.brown,
            value: widget.emocionAntes.surprised,
            title:
                widget.emocionAntes.surprised.toString().replaceAll(".0", "") +
                    "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.brown,
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/surprised.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );

        default:
          return null;
      }
    });
    list.removeWhere((element) => element.value == 101.0);
    return list;
  }

  Iterable<int> get positiveIntegers sync* {
    int i = 0;
    while (true) yield i++;
  }

  List<PieChartSectionData> showingSectionsAfter() {
    var list = List.generate(6, (i) {
      final isTouched = i == touchedIndexAfter;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 35 : 30;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: widget.emocionDespues.angry,
            title: widget.emocionDespues.angry.toString().replaceAll(".0", "") +
                "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xff0293ee),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/angry.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: widget.emocionDespues.disgust,
            title:
                widget.emocionDespues.disgust.toString().replaceAll(".0", "") +
                    "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xfff8b250),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/disgust.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: widget.emocionDespues.happy,
            title: widget.emocionDespues.happy.toString().replaceAll(".0", "") +
                "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xff845bef),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/happy.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: widget.emocionDespues.sad,
            title:
                widget.emocionDespues.sad.toString().replaceAll(".0", "") + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Color(0xff13d38e),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/sad.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Colors.red,
            value: widget.emocionDespues.scared,
            title:
                widget.emocionDespues.scared.toString().replaceAll(".0", "") +
                    "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/scared.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 5:
          return PieChartSectionData(
            color: Colors.brown,
            value: widget.emocionDespues.surprised,
            title: widget.emocionDespues.surprised
                    .toString()
                    .replaceAll(".0", "") +
                "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Container(
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.brown,
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/emociones/surprised.png',
                height: 30,
              ),
            ),
            badgePositionPercentageOffset: .98,
          );

        default:
          return null;
      }
    });
    list.removeWhere((element) => element.value == 101.0);

    return list;
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key key,
    @required this.size,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
          child: Image.network(
              "https://i.pinimg.com/236x/6f/89/53/6f8953bb7b53fb4fc1e8cf69aac5dfab.jpg")),
    );
  }
}
