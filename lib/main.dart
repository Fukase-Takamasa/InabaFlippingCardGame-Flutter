import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
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
    var tapCardsEnabled = true;

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
                        if (tapCardsEnabled) {
                          print("//カードタップ有効です");
                          print("//まずカードが閉じているか確認");
                          if (snapshot.data.documents[index]["isOpened"] == false) {
                            if (flipCount == 1) {
                              print("//フリップが1回目の場合 -> カードをめくる処理と、indexの記録");
                              flipCount = 2;
                              flippedCard[0] = index;
                              //DBのisOpenedをtrueに更新する
                              Firestore.instance
                                  .collection("currentGameTableData")
                                  .document("cardData${index + 1}")
                                  .setData({
                                "isOpened": true
                              }, merge: true);
                            }else {
                              print("//フリップが2回目の場合 -> 2枚がマッチしてるかジャッジ");
                              flippedCard[1] = index;
                              if (snapshot.data.documents[flippedCard[0]]["imageName"] ==
                                  snapshot.data.documents[flippedCard[1]]["imageName"]) {
                                print("//マッチした！両方のisOpened / isMatchedをtrueにする");
                                Firestore.instance
                                    .collection("currentGameTableData")
                                    .document("cardData${flippedCard[0] + 1}")
                                    .setData({
                                  "isOpened": true,
                                  "isMatched": true
                                }, merge: true);
                                Firestore.instance
                                    .collection("currentGameTableData")
                                    .document("cardData${flippedCard[1] + 1}")
                                    .setData({
                                  "isOpened": true,
                                  "isMatched": true
                                }, merge: true);
                                print("//カウントを1に戻し、index記録を0,0に戻す");
                                flipCount = 1;
                                flippedCard = [0, 0];
                              }else {
                                print("//マッチしなかったorz");
                                print("//ここで一旦 isOpened: trueだけ送信する(ユーザーにカードを見せる為)");
                                print("//また、2秒後にカードを閉じるまでの間にカードを触れなくする");
                                tapCardsEnabled = false;
                                Firestore.instance
                                    .collection("currentGameTableData")
                                    .document("cardData${index + 1}")
                                    .setData({
                                  "isOpened": true,
                                }, merge: true);
                                print("//マッチしていないので2秒後にカードを両方とも閉じる");
                                sleep(Duration(seconds: 2));
                                Firestore.instance
                                    .collection("currentGameTableData")
                                    .document("cardData${flippedCard[0] + 1}")
                                    .setData({
                                  "isOpened": false,
                                }, merge: true);
                                Firestore.instance
                                    .collection("currentGameTableData")
                                    .document("cardData${flippedCard[1] + 1}")
                                    .setData({
                                  "isOpened": false,
                                }, merge: true);
                                print("//最後にカウントとindexとカードタップ可否を元に戻す");
                                flipCount = 1;
                                flippedCard = [0, 0];
                                tapCardsEnabled = true;
                              }
                            }
                          }
                          print("現在のindex: $index");
                          print("flippedCard: $flippedCard");
                        }else {
                          print("カートタップが無効です");
                        }
                    },

                      child: ((){
                        if (snapshot.data.documents[index]["isMatched"] || snapshot.data.documents[index]["isOpened"]) {
                          return photoItem(snapshot.data.documents[index]["imageName"]) != null ?
                          photoItem(snapshot.data.documents[index]["imageName"])
                                : Text("Loading...");
                        }else {
                          if (index % 2 == 0) {
                            return photoItem("CardBackImageRed") != null ?
                            photoItem("CardBackImageRed")
                                : Text("Loading...");
                          }else {
                            return photoItem("CardBackImageBlue") != null ?
                            photoItem("CardBackImageBlue")
                                : Text("Loading...");
                          }
                        }
                      }()),
                    );
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