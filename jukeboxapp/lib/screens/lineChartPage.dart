import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jukeboxapp/model/emociones.dart';

class LineChartPage extends StatefulWidget {
  final List<Emociones> historico;

  LineChartPage({
    Key key,
    @required this.historico,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartPageState();
}

class LineChartPageState extends State<LineChartPage> {
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  double contadorSesiones = 1;

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
   
    return ListView(
      children: [
        Container(
          child: Text(
            "Feliz",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0, left: 12.0),
            child: LineChart(
              mainDataHappy(),
            ),
          ),
        ),
        Container(
          child: Text(
            "Triste",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0, left: 12.0),
            child: LineChart(
              mainDataSad(),
            ),
          ),
        ),
        Container(
          child: Text(
            "Enojado",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0, left: 12.0),
            child: LineChart(
              mainDataAngry(),
            ),
          ),
        ),
        Container(
          child: Text(
            "Asustado",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0, left: 12.0),
            child: LineChart(
              mainDataScared(),
            ),
          ),
        ),
        Container(
          child: Text(
            "Sorprendido",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0, left: 12.0),
            child: LineChart(
              mainDataSurprised(),
            ),
          ),
        ),
        Container(
          child: Text(
            "Disgustado",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        ),
        AspectRatio(
          aspectRatio: 3,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0, left: 12.0),
            child: LineChart(
              mainDataDisgust(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainDataHappy() {
    int numRegistros = widget.historico.length;
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
      maxX: numRegistros.toDouble(),
      minY: -1,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 1; i <= numRegistros; i++)
              FlSpot(
                  i.toDouble(),
                  widget.historico[i - 1].happy == 101.0
                      ? 0
                      : (widget.historico[i - 1].happy) / 10),
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

  LineChartData mainDataSad() {
    int numRegistros = widget.historico.length;
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
      maxX: numRegistros.toDouble(),
      minY: -1,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 1; i <= numRegistros; i++)
              FlSpot(
                  i.toDouble() - 1,
                  widget.historico[i - 1].sad == 101.0
                      ? 0
                      : (widget.historico[i - 1].sad) / 10),
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

  LineChartData mainDataAngry() {
    int numRegistros = widget.historico.length;
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
      maxX: numRegistros.toDouble(),
      minY: -1,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 1; i <= numRegistros; i++)
              FlSpot(
                  i.toDouble() - 1,
                  widget.historico[i - 1].angry == 101.0
                      ? 0
                      : (widget.historico[i - 1].angry) / 10),
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

  LineChartData mainDataScared() {
    int numRegistros = widget.historico.length;
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
      maxX: numRegistros.toDouble(),
      minY: -1,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 1; i <= numRegistros; i++)
              FlSpot(
                  i.toDouble() - 1,
                  widget.historico[i - 1].scared == 101.0
                      ? 0
                      : (widget.historico[i - 1].scared) / 10),
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

  LineChartData mainDataSurprised() {
    int numRegistros = widget.historico.length;
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
      maxX: numRegistros.toDouble(),
      minY: -1,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 1; i <= numRegistros; i++)
              FlSpot(
                  i.toDouble() - 1,
                  widget.historico[i - 1].surprised == 101.0
                      ? 0
                      : (widget.historico[i - 1].surprised) / 10),
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

  LineChartData mainDataDisgust() {
    int numRegistros = widget.historico.length;
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
      maxX: numRegistros.toDouble(),
      minY: -1,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 1; i <= numRegistros; i++)
              FlSpot(
                  i.toDouble() - 1,
                  widget.historico[i - 1].disgust == 101.0
                      ? 0
                      : (widget.historico[i - 1].disgust) / 10),
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
