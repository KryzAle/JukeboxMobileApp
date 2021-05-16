import 'package:flutter/material.dart';
import 'package:jukeboxapp/screens/pieChartPage.dart';
import 'package:jukeboxapp/screens/lineChartPage.dart';
import 'package:jukeboxapp/services/emociones_provider.dart';
import 'package:jukeboxapp/model/emociones.dart';

class ControlPage extends StatefulWidget {
  ControlPage({Key key}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  final api = EmocionesProvider();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
            backgroundColor: Colors.white,
            bottom: TabBar(labelColor: Colors.black, tabs: [
              Tab(
                icon: Icon(Icons.pie_chart_sharp),
                text: 'Control',
              ),
              Tab(
                icon: Icon(Icons.show_chart_outlined),
                text: 'Progreso',
              ),
            ]),
          ),
          body: TabBarView(children: [
            FutureBuilder<List<Emociones>>(
              future: api.getControlEmociones(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.last.fecha);
                  return PieChartPage(
                    emocionAntes: snapshot.data.first,
                    emocionDespues: snapshot.data.last,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            ),
            LineChartPage(),
          ]),
        ));
  }
}
