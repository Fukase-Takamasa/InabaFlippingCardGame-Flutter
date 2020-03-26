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
    Size deviceSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("currentGameTableData")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 30,
                  padding: EdgeInsets.only(top: deviceSize.height * 0.18,
                      bottom: deviceSize.height * 0.2,
                      left: deviceSize.width * 0.04,
                      right: deviceSize.width * 0.04),
                  itemBuilder: (context, index) {

                    if (snapshot.data.documents[index]["isOpened"] == true) {
                      print("itemBuilderの中です isOpened trueの方");
                      return GestureDetector(
                        onTap: () {
                          if (snapshot.data.documents[index]["isOpened"] == false) {
                            setState(() {
                              //DBのisOpenedをtrueに更新する
                            });
                          }else if (snapshot.data.documents[index]["isOpened"] == true) {
                              //DBのisOpenedをfalseに更新する
                          }
                          print(snapshot.data.documents[index]["imageName"]);
                          print(snapshot.data.documents[index]["isOpened"]);
                          print(snapshot.data.documents[index]["isMatched"]);
                        },

                        child: photoItem(snapshot.data.documents[index]["imageName"]) != null ?
                        photoItem(snapshot.data.documents[index]["imageName"])
                            : Text("Loading...")
//                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(4),
//                  )
                      );
                      print("あ");
                    }else {
                      print("itemBuilderの中です isOpened falseの方");
                      return GestureDetector(
                        onTap: () {
                          if (snapshot.data.documents[index]["isOpened"] == false) {
                            setState(() {
                              //DBのisOpenedをtrueに更新する
                            });
                          }else if (snapshot.data.documents[index]["isOpened"] == true) {
                            //DBのisOpenedをfalseに更新する
                          }
                          print(snapshot.data.documents[index]["imageName"]);
                          print(snapshot.data.documents[index]["isOpened"]);
                          print(snapshot.data.documents[index]["isMatched"]);
                        },
//                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
                        child: photoItem("CardBackImageRed") != null ?
                        photoItem("CardBackImageRed")
                          : Text("Loading...")
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(4),
//                  )
                      );
//                return photoItem("CardBackImageRed");
                    }

//                    if (index < 30) {
//                      return photoItem(
//                          snapshot.data.documents[index]["imageName"]) != null
//                          ? photoItem(
//                          snapshot.data.documents[index]["imageName"])
//                          : Text("Loading...");
//                    } else {
//                      return null;
//                    }
                  }
              );
            }
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