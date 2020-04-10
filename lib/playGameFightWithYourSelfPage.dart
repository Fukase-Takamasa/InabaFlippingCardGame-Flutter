import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cardData.dart';

class PlayGameFightWithYourSelfPage extends StatefulWidget {
  PlayGameFightWithYourSelfPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlayGameFightWithYourSelfPageState createState() => _PlayGameFightWithYourSelfPageState();
}

class _PlayGameFightWithYourSelfPageState extends State<PlayGameFightWithYourSelfPage> {

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    var flipCount = 1;
    var flippedCard = [0, 0];
    var tapCardsEnabled = true;

    List<CardData> inabaCards = [];
    List<num> randomNumList = [];
    for (var i = 1; i < 31; i++) {
      randomNumList += [i];
    }
    randomNumList.shuffle();
    for (var random in randomNumList) {
      inabaCards += [CardData(imageName: "ina$random", isOpened: "false", isMatched: "false")];
    }

    print("inabaCards: $inabaCards");

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Text("FightWithYourSelf画面"),
        )
//        GridView.builder(
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: 6,
//              crossAxisSpacing: 10,
//              mainAxisSpacing: 10,
//              childAspectRatio: 0.7,
//            ),
//            itemCount: 30,
//            padding: EdgeInsets.only(top: deviceSize.height * 0.18,
//                bottom: deviceSize.height * 0.2,
//                left: deviceSize.width * 0.04,
//                right: deviceSize.width * 0.04),
//            itemBuilder: (context, index) {
//              return GestureDetector(
//                //セルに表示する画像の設定
//                child: ((){  //←　child:の中でif文を使うために ((){ 処理内容 }())　で囲って関数化している
//                  if (snapshot.data.documents[index]["isMatched"] || snapshot.data.documents[index]["isOpened"]) {
//                    return photoItem(snapshot.data.documents[index]["imageName"]) != null ?
//                    photoItem(snapshot.data.documents[index]["imageName"])
//                        : Text("Loading...");
//                  }else {
//                    if (index % 2 == 0) {
//                      return photoItem("CardBackImageRed") != null ?
//                      photoItem("CardBackImageRed")
//                          : Text("Loading...");
//                    }else {
//                      return photoItem("CardBackImageBlue") != null ?
//                      photoItem("CardBackImageBlue")
//                          : Text("Loading...");
//                    }
//                  }
//                }()),
//                //セルタップ時のアクションの設定
//                onTap: (){
//                  if (tapCardsEnabled) {
//                    print("カードタップ有効です");
//                    if (snapshot.data.documents[index]["isOpened"] == false) {
//                      print("閉じていたのでめくります");
//                      if (flipCount == 1) {
//                        print("フリップが1回目 -> カードをめくる処理と、indexの記録");
//                        flipCount = 2;
//                        flippedCard[0] = index;
//                        Firestore.instance
//                            .collection("rooms")
//                            .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
//                            .collection("cardData")
//                            .document("cardData${index + 1}")
//                            .setData({
//                          "isOpened": true
//                        }, merge: true);
//                      }else {
//                        print("//フリップが2回目 -> 2枚がマッチしてるかジャッジ");
//                        flippedCard[1] = index;
//                        if (snapshot.data.documents[flippedCard[0]]["imageName"] ==
//                            snapshot.data.documents[flippedCard[1]]["imageName"]) {
//                          print("//マッチした！両方のisOpened / isMatchedをtrueにする");
//                          Firestore.instance
//                              .collection("rooms")
//                              .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
//                              .collection("cardData")
//                              .document("cardData${flippedCard[0] + 1}")
//                              .setData({
//                            "isOpened": true,
//                            "isMatched": true
//                          }, merge: true);
//                          Firestore.instance
//                              .collection("rooms")
//                              .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
//                              .collection("cardData")
//                              .document("cardData${flippedCard[1] + 1}")
//                              .setData({
//                            "isOpened": true,
//                            "isMatched": true
//                          }, merge: true);
//                          print("//カウントを1に戻し、index記録を0,0に戻す");
//                          flipCount = 1;
//                          flippedCard = [0, 0];
//                        }else {
//                          print("//マッチしなかったorz");
//                          print("//ここで一旦 isOpened: trueだけ送信する(ユーザーにカードを見せる為)");
//                          print("//また、2秒後にカードを閉じるまでの間にカードを触れなくする");
//                          tapCardsEnabled = false;
//                          Firestore.instance
//                              .collection("rooms")
//                              .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
//                              .collection("cardData")
//                              .document("cardData${index + 1}")
//                              .setData({
//                            "isOpened": true,
//                          }, merge: true);
//                          print("//遅延処理予約　1.5秒後に実行される");
//                          Future.delayed(Duration(milliseconds: 1500), () {
//                            print("//遅延処理実行開始 カードを両方とも閉じる");
//                            Firestore.instance
//                                .collection("rooms")
//                                .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
//                                .collection("cardData")
//                                .document("cardData${flippedCard[0] + 1}")
//                                .setData({
//                              "isOpened": false,
//                            }, merge: true);
//                            Firestore.instance
//                                .collection("rooms")
//                                .document("7153904E-F915-47B3-B9B8-25DFF479B60ERoom")
//                                .collection("cardData")
//                                .document("cardData${flippedCard[1] + 1}")
//                                .setData({
//                              "isOpened": false,
//                            }, merge: true);
//                            print("//最後にカウントとindexとカードタップ可否を元に戻す");
//                            flipCount = 1;
//                            flippedCard = [0, 0];
//                            tapCardsEnabled = true;
//                          });
//                        }
//                      }
//                    }else {
//                      print("開いているカードは触れません");
//                    }
//                    print("現在のindex: $index");
//                    print("flippedCard: $flippedCard");
//                  }else {
//                    print("カートタップが無効です");
//                  }
//                },
//              );
//            }
//        );
    );
  }


  //指定の画像名でwidgetを生成し、returnする関数  →　photoItem("ina1")の様に使う
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