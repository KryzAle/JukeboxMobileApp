import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Text("Ultima Sesión",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10.0),
        ),
        Container(
          child: Text("Antes",style: TextStyle(fontSize: 14),),
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
                    pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
                        if (desiredTouch && pieTouchResponse.touchedSection != null) {
                          touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
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
          child: Text("Despues",style: TextStyle(fontSize: 14),),
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
                    pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
                        if (desiredTouch && pieTouchResponse.touchedSection != null) {
                          touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
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
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/librarian-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          return null;
      }
    });
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
        child: Image.network("https://i.pinimg.com/236x/6f/89/53/6f8953bb7b53fb4fc1e8cf69aac5dfab.jpg")
      ),
    );
  }
}