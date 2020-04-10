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
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.green,
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
      body: Center(
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Text("自分との戦い"),
              onPressed: () =>  //MyAppのところでroutesに記述したIdentifierを元に遷移
                  Navigator.of(context).pushNamed("/PlayGameFightWithYourSelf"),
            ),
            RaisedButton(
              child: Text("オンラインで遊ぶ"),
              onPressed: () =>  //MyAppのところでroutesに記述したIdentifierを元に遷移
                  Navigator.of(context).pushNamed("/playGameFirestoreOnline"),
            ),
          ],
        )
//        RaisedButton(
//          child: Text("オンラインで遊ぶ"),
//          onPressed: () =>  //MyAppのところでroutesに記述したIdentifierを下に遷移
//            Navigator.of(context).pushNamed("/playGameFirestoreOnline"),
//        ),
      ),
    );
  }
}