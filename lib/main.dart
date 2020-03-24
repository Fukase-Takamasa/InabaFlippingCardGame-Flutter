import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cardData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InabaFlippingCardGame',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    List<CardData> inabaCards = <CardData>[];

    var imageList = [
      photoItem("ina1"), photoItem("ina2"), photoItem("ina3"),
      photoItem("ina4"), photoItem("ina5"), photoItem("ina6"),
      photoItem("ina7"), photoItem("ina8"), photoItem("ina9"),
      photoItem("ina10"), photoItem("ina11"), photoItem("ina12"),
      photoItem("ina13"), photoItem("ina14"), photoItem("ina15"),
      photoItem("ina1"), photoItem("ina2"), photoItem("ina3"),
      photoItem("ina4"), photoItem("ina5"), photoItem("ina6"),
      photoItem("ina7"), photoItem("ina8"), photoItem("ina9"),
      photoItem("ina10"), photoItem("ina11"), photoItem("ina12"),
      photoItem("ina13"), photoItem("ina14"), photoItem("ina15")
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 100),
        child: GridView.count(
          //GridView.countはWidget名で、画面に入りきるセル数ではなく、
          // 自分で指定した(count)セル数を表示する
          crossAxisCount: 6, //1行に表示する数
          crossAxisSpacing: 10, //縦スペース
          mainAxisSpacing: 10, //横スペース
          childAspectRatio: 0.7, //セルの縦横比
          shrinkWrap: true,

//          children: imageList

          children: List.generate(30, (index) { //セル数
            return Container(
            padding: const EdgeInsets.all(2.0),
              child: imageList[index],
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      )
    );
  }

  Widget photoItem(String image) {
    var assetsImage = "images/" + image + ".jpg";
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.asset(assetsImage, fit: BoxFit.cover)
      )
    );
  }
}












