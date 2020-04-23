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

  var turnCount = 50;
  var flipCount = 1;
  var flippedCard = [0, 0];
  var tapCardsEnabled = true;

  List<CardData> inabaCards = [];
  List<num> randomNumList = [];

  @override
  void initState() {
    super.initState();
    for (var i = 1; i < 31; i++) {
      randomNumList += [(i > 15 ? i - 15 : i)];
    }
    randomNumList.shuffle();
    print("カンニングシート${randomNumList.sublist(0, 6)}");
    print("カンニングシート${randomNumList.sublist(6, 12)}");
    print("カンニングシート${randomNumList.sublist(12, 18)}");
    print("カンニングシート${randomNumList.sublist(18, 24)}");
    print("カンニングシート${randomNumList.sublist(24, 30)}");

    for (var random in randomNumList) {
      inabaCards += [CardData(imageName: "ina$random", isOpened: false, isMatched: false)];
    }
    for (var card in inabaCards) {
      print("inabaCardsの中身: ${card.imageName} ${card.isOpened} ${card.isMatched}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          backgroundColor: Colors.amber[100],
        ),
        backgroundColor: Colors.amber,
        body: Center(
          child: Container(
          width: deviceWidth * 0.9,
          height: deviceHeight * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: deviceHeight * 0.18,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(right: 8),
                        child: Text("残り",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black,),
                          strutStyle: StrutStyle(fontSize: 45),
                        ),
                      ),
                      Container(
                        child: Text(turnCount.toString(),
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black,),
                        ),
                      ),

                      Container(padding: EdgeInsets.only(left: 8),
                        child: Text("ターン",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black,),
                          strutStyle: StrutStyle(fontSize: 45),
                        ),
                      ),
                    ],
                  ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 0),
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
                        if (inabaCards[index].isMatched || inabaCards[index].isOpened) {
                          return photoItem(inabaCards[index].imageName) != null ? photoItem(inabaCards[index].imageName) : Text("ImageNotFound");
                        }else {
                          if (index % 2 == 0) {
                            return photoItem("CardBackImageRed") != null ? photoItem("CardBackImageRed") : Text("ImageNotFound");
                          }else {
                            return photoItem("CardBackImageRed") != null ? photoItem("CardBackImageBlue") : Text("ImageNotFound");
                          }
                        }
                      }()),
                      //セルタップ時のアクションの設定
                      onTap: (){
                        if (tapCardsEnabled) {
                          print("カードタップ有効です");
                          if (inabaCards[index].isOpened == false) {
                            print("閉じていたのでめくります");
                            if (flipCount == 1) {
                              print("フリップが1回目 -> カードをめくる処理と、indexの記録");
                              flipCount = 2;
                              flippedCard[0] = index;
                              setState(() {
                                inabaCards[flippedCard[0]].isOpened = true;
                              });
                              print("カード1の状況: ${inabaCards[flippedCard[0]].imageName} ${inabaCards[flippedCard[0]].isOpened} ${inabaCards[flippedCard[0]].isMatched}");
                            }else {
                              print("//フリップが2回目 -> 2枚がマッチしてるかジャッジ");
                              flippedCard[1] = index;
                              if (inabaCards[flippedCard[0]].imageName ==
                                  inabaCards[flippedCard[1]].imageName) {
                                print("//マッチした！両方のisOpened / isMatchedをtrueにする");
                                setState(() {
                                  turnCount -= 1;
                                  inabaCards[flippedCard[0]].isOpened = true;
                                  inabaCards[flippedCard[0]].isMatched = true;
                                  inabaCards[flippedCard[1]].isOpened = true;
                                  inabaCards[flippedCard[1]].isMatched = true;
                                });
                                print("//カウントを1に戻し、index記録を0,0に戻す");
                                flipCount = 1;
                                flippedCard = [0, 0];
                              }else {
                                print("//マッチしなかったorz");
                                print("//ここで一旦 isOpened: trueにする（ユーザーにカードを見せる為)");
                                print("//また、2秒後にカードを閉じるまでの間にカードを触れなくする");
                                tapCardsEnabled = false;
                                setState(() {
                                  inabaCards[flippedCard[1]].isOpened = true;
                                });
                                print("//遅延処理予約　1.5秒後に実行される");
                                Future.delayed(Duration(milliseconds: 1500), () {
                                  print("//遅延処理実行開始 カードを両方とも閉じる");
                                  setState(() {
                                    turnCount -= 1;
                                    inabaCards[flippedCard[0]].isOpened = false;
                                    inabaCards[flippedCard[1]].isOpened = false;
                                  });
                                  print("//最後にカウントとindexとカードタップ可否を元に戻す");
                                  flipCount = 1;
                                  flippedCard = [0, 0];
                                  tapCardsEnabled = true;
                                });
                              }
                              print("カード1の状況: ${inabaCards[flippedCard[0]].imageName} ${inabaCards[flippedCard[0]].isOpened} ${inabaCards[flippedCard[0]].isMatched}");
                              print("カード2の状況: ${inabaCards[flippedCard[1]].imageName} ${inabaCards[flippedCard[1]].isOpened} ${inabaCards[flippedCard[1]].isMatched}");
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
            )
            ),
            Container(
              height: deviceHeight * 0.18, //スペーサー
            )
              ],
            )
      )
    ),
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