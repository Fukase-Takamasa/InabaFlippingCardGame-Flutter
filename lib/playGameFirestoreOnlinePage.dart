import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlayGameFirestoreOnlinePage extends StatefulWidget {
  PlayGameFirestoreOnlinePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlayGameFirestoreOnlinePageState createState() => _PlayGameFirestoreOnlinePageState();
}

class _PlayGameFirestoreOnlinePageState extends State<PlayGameFirestoreOnlinePage> {

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    var flipCount = 1;
    var flippedCard = [0, 0];
    var tapCardsEnabled = true;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("rooms")
                .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
                .collection("cardData")
                .orderBy("id")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }
              return Center(
                child: Container(
                  width: deviceWidth * 0.9,
                  height: deviceHeight * 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: deviceHeight * 0.18, //スペーサー
                      ),
                      Expanded(
                        child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: deviceWidth * 0.024,
                    mainAxisSpacing: deviceHeight * 0.01,
                    childAspectRatio: ((deviceWidth * 0.9) / (deviceHeight * 0.67)),
                  ),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      //セルに表示する画像の設定
                      child: ((){  //←　child:の中でif文を使うために ((){ 処理内容 }())　で囲って関数化している
                        if (snapshot.data.documents[index]["isMatched"] || snapshot.data.documents[index]["isOpened"]) {
                          return photoItem(snapshot.data.documents[index]["imageName"]) != null ? photoItem(snapshot.data.documents[index]["imageName"]) : Text("Loading...");
                        }else {
                          if (index % 2 == 0) {
                            return photoItem("CardBackImageRed") != null ? photoItem("CardBackImageRed") : Text("Loading...");
                          }else {
                            return photoItem("CardBackImageBlue") != null ? photoItem("CardBackImageBlue") : Text("Loading...");
                          }
                        }
                      }()),
                      //セルタップ時のアクションの設定
                      onTap: (){
                        if (tapCardsEnabled) {
                          print("カードタップ有効です");
                          if (snapshot.data.documents[index]["isOpened"] == false) {
                            print("閉じていたのでめくります");
                            if (flipCount == 1) {
                              print("フリップが1回目 -> カードをめくる処理と、indexの記録");
                              flipCount = 2;
                              flippedCard[0] = index;
                              Firestore.instance
                                  .collection("rooms")
                                  .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
                                  .collection("cardData")
                                  .document("cardData${index + 1}")
                                  .setData({
                                "isOpened": true
                              }, merge: true);
                            }else {
                              print("//フリップが2回目 -> 2枚がマッチしてるかジャッジ");
                              flippedCard[1] = index;
                              if (snapshot.data.documents[flippedCard[0]]["imageName"] ==
                                  snapshot.data.documents[flippedCard[1]]["imageName"]) {
                                print("//マッチした！両方のisOpened / isMatchedをtrueにする");
                                Firestore.instance
                                    .collection("rooms")
                                    .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
                                    .collection("cardData")
                                    .document("cardData${flippedCard[0] + 1}")
                                    .setData({
                                  "isOpened": true,
                                  "isMatched": true
                                }, merge: true);
                                Firestore.instance
                                    .collection("rooms")
                                    .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
                                    .collection("cardData")
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
                                    .collection("rooms")
                                    .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
                                    .collection("cardData")
                                    .document("cardData${index + 1}")
                                    .setData({
                                  "isOpened": true,
                                }, merge: true);
                                print("//遅延処理予約　1.5秒後に実行される");
                                Future.delayed(Duration(milliseconds: 1500), () {
                                  print("//遅延処理実行開始 カードを両方とも閉じる");
                                  Firestore.instance
                                      .collection("rooms")
                                      .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
                                      .collection("cardData")
                                      .document("cardData${flippedCard[0] + 1}")
                                      .setData({
                                    "isOpened": false,
                                  }, merge: true);
                                  Firestore.instance
                                      .collection("rooms")
                                      .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
                                      .collection("cardData")
                                      .document("cardData${flippedCard[1] + 1}")
                                      .setData({
                                    "isOpened": false,
                                  }, merge: true);
                                  print("//最後にカウントとindexとカードタップ可否を元に戻す");
                                  flipCount = 1;
                                  flippedCard = [0, 0];
                                  tapCardsEnabled = true;
                                });
                              }
                            }
                          }else {
                            print("開いているカードは触れません");
                          }
                          print("現在のindex: $index");
                          print("flippedCard: $flippedCard");
                        }else {
                          print("カートタップが無効です");
                        }
                      },
                    );
                  }
              )
                      ),
                      Container(
                        height: deviceHeight * 0.18, //スペーサー
                      )
                    ],
                  ),
                )
              );
            }
        )
    );
  }


  //指定の画像名でwidgetを生成し、returnする関数  →　photoItem("ina1")の様に使う
  Widget photoItem(String image) {
    var assetsImage = "images/" + image + ".jpg";
    return ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
            color: Colors.white,
            child: Image.asset(
                assetsImage,
                fit: (image == "CardBackImageRed") || (image == "CardBackImageBlue") ? BoxFit.fill : BoxFit.contain
            )
        )
    );
  }

}