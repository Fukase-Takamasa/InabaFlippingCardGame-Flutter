import 'package:flutter/material.dart';

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

          shrinkWrap: true,
          children: List.generate(30, (index) { //セル数
            return Container(
//            padding: const EdgeInsets.only(top: 20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),

            );
          }),

        ),
      )

    );
  }
}












