import 'package:flutter/material.dart';
import 'package:jukeboxapp/screens/pieChartPage.dart';
import 'package:jukeboxapp/screens/lineChartPage.dart';

class ControlPage extends StatefulWidget {
  ControlPage({Key key}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.pie_chart_sharp),text: 'Control',),
              Tab(icon: Icon(Icons.show_chart_outlined),text: 'Progreso',),
            ]
          ),
        ),
        body: TabBarView(
          children: [
             PieChartPage(),
             LineChartPage(),
          ]
        ),
      )
      );
  }
}