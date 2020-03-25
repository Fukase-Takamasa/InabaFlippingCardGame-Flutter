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

    Size deviceSize = MediaQuery.of(context).size;

    List<CardData> inabaCards = <CardData>[
      CardData(imageName: "ina1", isOpened: "true", isMatched: "false"),
      CardData(imageName: "ina2", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina3", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina4", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina5", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina6", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina7", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina8", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina9", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina10", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina11", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina12", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina13", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina14", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina15", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina1", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina2", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina3", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina4", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina5", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina6", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina7", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina8", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina9", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina10", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina11", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina12", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina13", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina14", isOpened: "false", isMatched: "false"),
      CardData(imageName: "ina15", isOpened: "true", isMatched: "false")
    ];

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("currentGameTableData")
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (snapshot.hasError) {
//          return Text("Error: ${snapshot.error}");
//        }
//        switch (snapshot.connectionState) {
//          case ConnectionState.waiting: return Text("Loading...");
//          default:
//            return GridView(
//              children: snapshot.data.documents.map((DocumentSnapshot document) {
//                return Container(
//                  child: photoItem(document["imageName"]),
//                );
//              }).toList(),
//            );
//        }
        if (!snapshot.hasData) return const Text('Loading...');

//        return GridView(
//              children: snapshot.data.documents.map((DocumentSnapshot document) {
//                return Container(
//                  child: photoItem(document["imageName"]),
//                );
//              }).toList(),
//            );
      return Center(
        child: Text("中身: ${snapshot.data.documents[0]["imageName"]}"),
      );
      },
    );

//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Container(
//        padding: EdgeInsets.only(
//          top: deviceSize.height * 0.18, bottom: deviceSize.height * 0.2,
//          left: deviceSize.width * 0.04, right: deviceSize.width * 0.04),
//        child: GridView.builder(
//          itemCount: inabaCards.length,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 6,
//            crossAxisSpacing: 10, //縦スペース
//            mainAxisSpacing: 10, //横スペース
//            childAspectRatio: 0.7, //セルの縦横比
//          ),
//          itemBuilder: (context, index) {
//            if (inabaCards[index].isOpened == "true") {
//              print("itemBuilderの中です isOpened trueの方");
//              return GestureDetector(
//                onTap: () {
//                  if (inabaCards[index].isOpened == "false") {
//                    inabaCards[index].isOpened = "true";
//                    setState(() {
//
//                    });
//                  }else if (inabaCards[index].isOpened == "true") {
//                    inabaCards[index].isOpened = "false";
//                  }
//                  print(inabaCards[index].imageName);
//                  print(inabaCards[index].isOpened);
//                  print(inabaCards[index].isMatched);
//                },
//
//                child: photoItem(inabaCards[index].imageName),
////                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
////                  alignment: Alignment.center,
////                  decoration: BoxDecoration(
////                    color: Colors.white,
////                    borderRadius: BorderRadius.circular(4),
////                  )
//              );
//              print("あ");
//            }else {
//              print("itemBuilderの中です isOpened falseの方");
//              return GestureDetector(
//                onTap: () {
//                  if (inabaCards[index].isOpened == "false") {
//                    inabaCards[index].isOpened = "true";
//                  }else if (inabaCards[index].isOpened == "true") {
//                    inabaCards[index].isOpened = "false";
//                  }
//                  print(inabaCards[index].imageName);
//                  print(inabaCards[index].isOpened);
//                  print(inabaCards[index].isMatched);
//                },
////                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
//                child: photoItem("CardBackImageRed"),
////                  alignment: Alignment.center,
////                  decoration: BoxDecoration(
////                    color: Colors.white,
////                    borderRadius: BorderRadius.circular(4),
////                  )
//              );
////                return photoItem("CardBackImageRed");
//            }
//          },
//        ),
//      ),
//    );
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