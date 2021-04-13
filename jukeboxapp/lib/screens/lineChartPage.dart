import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartPageState();
}

class LineChartPageState extends State<LineChartPage> {
  List<Color> gradientColors = [
     Color(0xff23b6e6),
     Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Text("Feliz",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(
                right: 18.0, left: 12.0),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        Container(
          child: Text("Triste",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(
                right: 18.0, left: 12.0),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        Container(
          child: Text("Enojado",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(
                right: 18.0, left: 12.0),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        Container(
          child: Text("Asustado",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(
                right: 18.0, left: 12.0),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        Container(
          child: Text("Sorprendido",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(
                right: 18.0, left: 12.0),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        Container(
          child: Text("Disgustado",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(
                right: 18.0, left: 12.0),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '25%';
              case 5:
                return '50%';
              case 10:
                return '100%';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 4),
            FlSpot(2, 2),
            FlSpot(3, 5),
            FlSpot(4, 3.1),
            FlSpot(5, 4),
            FlSpot(6.5, 3),
            FlSpot(7, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
