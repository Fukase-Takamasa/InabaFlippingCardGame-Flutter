import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'playGameFirestoreOnlinePage.dart';
import 'playGameFightWithYourSelfPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
              .collection("rooms")
              .orderBy("defaultRoom").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading...");
          }
          return       Container(
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
                            children: snapshot.data.documents.map((DocumentSnapshot document) {
                              return GestureDetector(
                                //タップのメソッド
                                onTap: () {
                                  Navigator.of(context).pushNamed("/playGameFirestoreOnline");
                                },
                                //UIの設定
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  child: Container(
                                    height: 40,
                                    padding: EdgeInsets.only(left: 10, top: 0, right: 10),
                                    color: Colors.white,
                                    child: ((){
//                                      return Text(document["roomName"]) != null ? Text(document["roomName"]) : Text("Loading...");
                                      var playerCount = (document.data.length - 3);
                                      var state = playerCount < 2 ? "参加する" : "満室";
                                      return roomItem(document["roomName"], playerCount.toString(), state) != null ?
                                      roomItem(document["roomName"], playerCount.toString(), state) : Text("Loading...");

                                    }()),
                                  ),
                                ),
                              );
                            }).toList(),
                        ),
                      ),

                    )
                )
              ],
            ),
          );
        },
      )
    );
  }


  Widget roomItem(String roomName, String playerCount, String state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: double.infinity),
          child: Text(roomName,
            style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.normal,
            color: Colors.black,)
          ),
        ),
        Expanded(
          child: Text("") // ←　上のmaxWidth: double.infinityと組み合わせて　いい感じのSpacerにしてる
        ),
        Text("$playerCount/2　",
          style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.normal,
          color: Colors.black,)
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 90, height: 32,
            color: (state != "満室") ? Colors.lightBlueAccent : Colors.orangeAccent,
            child: Text(state,
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold,
              color: Colors.white,)
            ),
          )
        ),
      ],
    );
  }
}