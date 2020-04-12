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
        '/playGameFirestoreOnline': (BuildContext context) =>  PlayGameFirestoreOnlinePage(title: 'FirestoreOnline'),
        '/PlayGameFightWithYourSelf': (BuildContext context) => PlayGameFightWithYourSelfPage(title: 'FightWithYourSelf'),
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title)
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child:
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              width: 400,
              height: 2,
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 280,
              height: 70,
              child: RaisedButton(
                child: Text("オンラインで遊ぶ"),
                onPressed: () =>  //MyAppのところでroutesに記述したIdentifierを元に遷移
                Navigator.of(context).pushNamed("/playGameFirestoreOnline"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 280,
              height: 70,
              child: RaisedButton(
                child: Text("自分との戦い"),
                onPressed: () =>  //MyAppのところでroutesに記述したIdentifierを元に遷移
                Navigator.of(context).pushNamed("/PlayGameFightWithYourSelf"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 400,
              height: 2,
              color: Colors.white,
            ),
            Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10),
                children: List.generate(5, (index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      margin: EdgeInsets.all(20),
                      color: Colors.white,
                      child: Text("ルーム$index"),
                    ),
                  );
                }
                )
              )
            )
          ],
      ),
    ),
    );
  }
}