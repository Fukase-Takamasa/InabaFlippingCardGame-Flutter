import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'cardData.dart';

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
      home: MyHomePage(title: 'InabaFlippingCardGame≪Flutter≫'),
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

    var flipCount = 1;
    var flippedCard = [0, 0];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("currentGameTableData")
                .orderBy("id")
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

                    return GestureDetector(
                      onTap: (){
                        if (snapshot.data.documents[index]["isOpened"] == false) {
                            //DBのisOpenedをtrueに更新する
                          Firestore.instance
                              .collection("currentGameTableData")
                              .document("cardData${index + 1}")
                              .setData({
                            "isOpened": true
                          }, merge: true);
                        }else if (snapshot.data.documents[index]["isOpened"] == true) {
                            //DBのisOpenedをfalseに更新する
                          Firestore.instance
                              .collection("currentGameTableData")
                              .document("cardData${index + 1}")
                              .setData({
                            "isOpened": false
                          }, merge: true);
                        }
                      },

                      child: ((){
                        print("childの中");
                        if (snapshot.data.documents[index]["isOpened"]) {
                          print("childの中1");
                          return photoItem(snapshot.data.documents[index]["imageName"]) != null ?
                          photoItem(snapshot.data.documents[index]["imageName"])
                                : Text("Loading...");
                        }else {
                          if (index % 2 == 0) {
                            print("childの中2");
                            return photoItem("CardBackImageRed") != null ?
                            photoItem("CardBackImageRed")
                                : Text("Loading...");
                          }else {
                            print("childの中3");
                            return photoItem("CardBackImageBlue") != null ?
                            photoItem("CardBackImageBlue")
                                : Text("Loading...");
                          }
                        }
                      }()),
                    );





















//                    if (snapshot.data.documents[index]["isOpened"] == true) {
//                      return GestureDetector(
//                        onTap: () {
//                          if (snapshot.data.documents[index]["isOpened"] == false) {
////                            setState(() {
//                              //DBのisOpenedをtrueに更新する
//                            Firestore.instance
//                                .collection("currentGameTableData")
//                                .document("cardData${index + 1}")
//                                .setData({
//                              "isOpened": true
//                            }, merge: true);
////                            });
//                          }else if (snapshot.data.documents[index]["isOpened"] == true) {
//                              //DBのisOpenedをfalseに更新する
//                            Firestore.instance
//                                .collection("currentGameTableData")
//                                .document("cardData${index + 1}")
//                                .setData({
//                              "isOpened": false
//                            }, merge: true);
//                          }
//                          print(snapshot.data.documents[index]["imageName"]);
//                          print(snapshot.data.documents[index]["isOpened"]);
//                          print(snapshot.data.documents[index]["isMatched"]);
//                        },
//
//                        child: photoItem(snapshot.data.documents[index]["imageName"]) != null ?
//                        photoItem(snapshot.data.documents[index]["imageName"])
//                            : Text("Loading...")
////                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
////                  alignment: Alignment.center,
////                  decoration: BoxDecoration(
////                    color: Colors.white,
////                    borderRadius: BorderRadius.circular(4),
////                  )
//                      );
//                      print("あ");
//                    }else {
//                      if (index % 2 == 0) {
//                        return GestureDetector(
//                            onTap: () {
//                              if (snapshot.data.documents[index]["isOpened"] == false) {
////                            setState(() {
//                                //DBのisOpenedをtrueに更新する
//                                Firestore.instance
//                                    .collection("currentGameTableData")
//                                    .document("cardData${index + 1}")
//                                    .setData({
//                                  "isOpened": true
//                                }, merge: true);
////                            });
//                              }else if (snapshot.data.documents[index]["isOpened"] == true) {
//                                //DBのisOpenedをfalseに更新する
//                                Firestore.instance
//                                    .collection("currentGameTableData")
//                                    .document("cardData${index + 1}")
//                                    .setData({
//                                  "isOpened": false
//                                }, merge: true);
//                              }
//                              print(snapshot.data.documents[index]["imageName"]);
//                              print(snapshot.data.documents[index]["isOpened"]);
//                              print(snapshot.data.documents[index]["isMatched"]);
//                            },
////                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
//                            child: photoItem("CardBackImageRed") != null ?
//                            photoItem("CardBackImageRed")
//                                : Text("Loading...")
////                  alignment: Alignment.center,
////                  decoration: BoxDecoration(
////                    color: Colors.white,
////                    borderRadius: BorderRadius.circular(4),
////                  )
//                        );
//                      }else {
//                        return GestureDetector(
//                            onTap: () {
//                              if (snapshot.data.documents[index]["isOpened"] == false) {
////                            setState(() {
//                                //DBのisOpenedをtrueに更新する
//                                Firestore.instance
//                                    .collection("currentGameTableData")
//                                    .document("cardData${index + 1}")
//                                    .setData({
//                                  "isOpened": true
//                                }, merge: true);
////                            });
//                              }else if (snapshot.data.documents[index]["isOpened"] == true) {
//                                //DBのisOpenedをfalseに更新する
//                                Firestore.instance
//                                    .collection("currentGameTableData")
//                                    .document("cardData${index + 1}")
//                                    .setData({
//                                  "isOpened": false
//                                }, merge: true);
//                              }
//                              print(snapshot.data.documents[index]["imageName"]);
//                              print(snapshot.data.documents[index]["isOpened"]);
//                              print(snapshot.data.documents[index]["isMatched"]);
//                            },
////                  padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
//                            child: photoItem("CardBackImageBlue") != null ?
//                            photoItem("CardBackImageBlue")
//                                : Text("Loading...")
////                  alignment: Alignment.center,
////                  decoration: BoxDecoration(
////                    color: Colors.white,
////                    borderRadius: BorderRadius.circular(4),
////                  )
//                        );
//                      }
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