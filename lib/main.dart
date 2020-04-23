import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'playGameFirestoreOnlinePage.dart';
import 'playGameFightWithYourSelfPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InabaFlippingCardGame',
      theme: ThemeData(
        primaryColor: Colors.lightGreen[100],
        scaffoldBackgroundColor: Colors.green[800],
      ),
      home: MyHomePage(title: 'ロビー«Flutter»'),
      routes: {
        '/playGameFirestoreOnline': (BuildContext context) =>  PlayGameFirestoreOnlinePage(title: 'ルーム1(デフォ)'),
        '/PlayGameFightWithYourSelf': (BuildContext context) => PlayGameFightWithYourSelfPage(title: '自分との戦い部屋'),
      },
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Size deviceScreenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title)
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child:
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      "ひとりで遊ぶ",
                      style: TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child:  Container(
                    padding: EdgeInsets.all(10),
                    width: deviceScreenSize.width * 0.83, height: 2, color: Colors.white,
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(10),
              width: deviceScreenSize.width * 0.75, height: 70,
              child: RaisedButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Icon(Icons.person_outline),
                      Text(
                        "自分との戦い",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87,
                      ),
                      ),
                    ]
                ),
                onPressed: () =>  //MyAppのところでroutesに記述したIdentifierを元に遷移
                Navigator.of(context).pushNamed("/PlayGameFightWithYourSelf"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: deviceScreenSize.width * 0.75, height: 70,
              child: RaisedButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                    Icon(Icons.desktop_mac),
                    Text(
                        "コンピュータと対戦",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87,
                        )
                    ),
                  ]
                ),
                onPressed: () =>  //MyAppのところでroutesに記述したIdentifierを元に遷移
                Navigator.of(context).pushNamed("/PlayGameFightWithYourSelf"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      "オンラインで遊ぶ",
                      style: TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child:  Container(
                    padding: EdgeInsets.all(10),
                    width: deviceScreenSize.width * 0.83, height: 2, color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: deviceScreenSize.width * 0.85,
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Colors.white,
                    ),
                    child: ListView(
//                      padding: EdgeInsets.all(10),
                        children: List.generate(3, (index) {
                          return GestureDetector(
                            //タップのメソッド
                            onTap: () {
                              Navigator.of(context).pushNamed("/playGameFirestoreOnline");
                            },
                            //UIの設定
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: EdgeInsets.only(left: 10, top: 10, right: 10), height: 40,
                                color: Colors.white,
                                child: Text(
                                  "ルーム${index + 1}（デフォルト）",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        )
                    ),
                  ),

              )
            )
          ],
      ),
    ),
    );
  }
}