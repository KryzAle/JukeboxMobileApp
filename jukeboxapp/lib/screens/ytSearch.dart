import 'package:flutter/material.dart';
import 'package:jukeboxapp/screens/Mp3Download.dart';
import 'package:youtube_api/youtube_api.dart';
import 'dart:math';

class YtSearch extends StatefulWidget {
  YtSearch({Key key}) : super(key: key);

  @override
  _YtSearchState createState() => _YtSearchState();
}

class _YtSearchState extends State<YtSearch> {
  static String key = "AIzaSyDv2salRVXRgfmDx4h950mVD4JjSwSTwg8";
  final myController = TextEditingController();
  YoutubeAPI ytApi = YoutubeAPI(key, type: "video");
  List<YT_API> ytResult = [];
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  callAPI(String query) async {
    ytResult = await ytApi.search(query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    recomendaciones();
  }

  Future<void> recomendaciones() async {
    final artistas = [
      "badbunny",
      "camilo",
      "the weekend",
      "shakira",
      "anuel aa",
      "Karol G",
      "J balvin"
    ];
    var rnd = random(0, 6);
    ytResult = await ytApi.search(artistas[rnd] + " lyrics");
    setState(() {});
  }

  int random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(9, 133, 46, 100)),
        backgroundColor: Colors.white,
        title: Text(
          "Selecciona una canción",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 150,
            child: Image.asset(
              "assets/images/youtube.png",
            ),
          ),
          Container(
            height: 50,
            width: 300,
            child: TextField(
              controller: myController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value != "") {
                  callAPI(value);
                }
              },
              decoration: InputDecoration(
                  hintText: " Buscar...",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (myController.text != "") {
                        callAPI(myController.text + " lyrics");
                      }
                      setState(() {
                        myController.text = "";
                      });
                    },
                  )),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ytResult.length,
              itemBuilder: (_, int index) => listItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(index) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Image.network(
              ytResult[index].thumbnail['default']['url'],
            ),
            Padding(padding: EdgeInsets.only(right: 20.0)),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(
                    ytResult[index].title,
                    softWrap: true,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 1.5)),
                  Text(
                    ytResult[index].channelTitle,
                    softWrap: true,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 3.0)),
                ])),
            IconButton(
                icon: Icon(
                  Icons.download_rounded,
                  color: Colors.red,
                ),
                onPressed: () {
                  _lanzarDownloader(
                      ytResult[index].url,
                      ytResult[index].thumbnail['default']['url'],
                      ytResult[index].title,
                      ytResult[index].channelTitle);
                }),
          ],
        ),
      ),
    );
  }

  void _lanzarDownloader(
      String url, String urlImg, String titulo, String canal) {
    //int tamUrl = url.indexOf("v=");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Mp3Downloader(
                  //idYoutube: url.substring(tamUrl + 2),
                  idYoutube: url,
                  imgYoutube: urlImg,
                  canalYoutube: canal,
                  tituloYoutube: titulo,
                )));
  }
}
