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
              initialData: [],
              future: api.getControlEmociones(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.length>0) {
                  return PieChartPage(
                    emocionAntes: snapshot.data[snapshot.data.length - 2],
                    emocionDespues: snapshot.data[snapshot.data.length - 1],
                  );
                } else if (snapshot.data.length==0) {
                  return Center(
                    child: Text("No existen datos que mostrar"),
                  );
                }
                return _progressIndicator();
              },
            ),
            FutureBuilder<List<Emociones>>(
              initialData: [],
              future: api.getControlEmociones(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return LineChartPage(historico: snapshot.data);
                } else if (snapshot.data.length==0) {
                  return Center(
                    child: Text("No existen datos que mostrar"),
                  );
                }
                return _progressIndicator();
              },
            ),
            //LineChartPage(),
          ]),
        ));
  }

  Widget _progressIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Procesando...",
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
