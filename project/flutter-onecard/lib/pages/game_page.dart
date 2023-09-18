import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onecard/model/card_style.dart';
import 'package:onecard/model/user.dart';
import 'package:onecard/module/btn_elevated_func.dart';
import 'package:onecard/module/game_helper.dart';
import 'package:onecard/module/on_back_key.dart';
import 'package:onecard/ui_models/timer_manager.dart';
import 'package:playing_cards/playing_cards.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, this.player});
  final GameUser? player;
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // This style object overrides the styles for spades.

  List<PlayingCard> deck = standardFiftyFourCardDeck();

  List<PlayingCard> playerDeck = [];
  List<PlayingCard> computerDeck = [];
  List<PlayingCard> gameDeck = [];

  int attackStack = 0;
  bool turn = true;
  bool gameEnd = false;
  bool playerTurn = false;
  bool computerTurn = false;

  int seconds = 20;
  bool isRunning = false;

  @override
  void initState() {
    turn = GameHelper().gameStart(
      context: context,
      boardDeck: gameDeck,
      computerDeck: computerDeck,
      deck: deck,
      playerDeck: playerDeck,
      nickname: widget.player?.nickname,
    );

    debugPrint("누가먼저? $turn");

    super.initState();
    // while (true) {
    //   return;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackKey(
        context: context,
        title: "게임을 종료하시겠습니까? 이대로 종료하시면 패배로 인정됩니다.",
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/MainPage_bg.png'), // 배경 이미지
          ),
        ),
        child: Scaffold(
          floatingActionButton: FloatingActionButton.small(
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: const Color.fromARGB(79, 255, 255, 255),
                barrierDismissible: true,
                builder: (context) {
                  return Dialog(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    insetPadding: const EdgeInsets.fromLTRB(30, 300, 30, 300),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          elevatedBtnFunc(context, btnText: "게임설명"),
                          elevatedBtnFunc(
                            context,
                            btnText: "게임종료",
                            onPressed: () async {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            heroTag: "actionButton",
            backgroundColor: const Color.fromARGB(255, 76, 130, 175),
            child: const Icon(Icons.menu),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          backgroundColor: const Color.fromARGB(0, 255, 193, 7),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 400,
                  child: playerCardDeck(computerDeck, true),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          playerDeck.add(deck.removeAt(0));
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 100,
                          child: PlayingCardView(
                            card: PlayingCard(Suit.spades, CardValue.ace),
                            showBack: true,
                            elevation: 3.0,
                            shape: shape,
                            style: myCardStyles,
                          ),
                        ),
                      ),
                      // elevatedBtn(context,
                      //     btnText: "OneCard", width: 180, fontSize: 20),
                      TimerPage(seconds: seconds, isRunning: isRunning),
                      SizedBox(
                        height: 100,
                        child: PlayingCardView(
                          card: gameDeck[gameDeck.length - 1],
                          // showBack: true,
                          elevation: 3.0,
                          shape: shape,
                          style: myCardStyles,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 400,
                  child: playerCardDeck(playerDeck, false),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> myDeck(List<PlayingCard> playerDeck, bool showBack) {
    List<Widget> cardWidgetList = [];

    for (int i = 0; i < playerDeck.length; i++) {
      bool isAble = false;
      int gameCardValue = GameHelper().stringToNumber(
          gameDeck[gameDeck.length - 1].value.toString().split(".")[1]);
      String gameCardSuit =
          gameDeck[gameDeck.length - 1].suit.toString().split(".")[1];
      int myCardValue = GameHelper()
          .stringToNumber(playerDeck[i].value.toString().split(".")[1]);
      String myCardSuit = playerDeck[i].suit.toString().split(".")[1];
      debugPrint("2222222222$myCardSuit");

      if (gameCardValue == myCardValue) {
        isAble = true;
      } else if (gameCardSuit == myCardSuit) {
        if (gameCardValue >= 100 ||
            myCardValue > 10 ||
            ((gameCardValue - myCardValue) >= -1 &&
                (gameCardValue - myCardValue) <= 1)) {
          isAble = true;
        }
      } else if (myCardValue == 500) {
        if (gameCardSuit == "clubs" || gameCardSuit == "spades") {
          isAble = true;
        }
      } else if (myCardValue == 700) {
        if (gameCardSuit == "hearts" || gameCardSuit == "diamonds") {
          isAble = true;
        }
      }

      cardWidgetList.add(
        Container(
          decoration: isAble || showBack
              ? null
              : BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 173, 173, 173)
                          .withOpacity(1),
                      blurRadius: 7.0,
                      spreadRadius: 1.0,
                      offset: const Offset(3, 7),
                    )
                  ],
                  // color: const Color.fromARGB(255, 163, 132, 132),
                ),
          child: PlayingCardView(
            card: playerDeck[i],
            showBack: showBack,
            elevation: 3.0,
            shape: isAble || showBack ? avalShape : shape,
            style: myCardStyles,
          ),
        ),
      );
    }

    return cardWidgetList;
  }

  Widget playerCardDeck(List<PlayingCard> cardDeck, bool showBack) {
    return FlatCardFan(
      children: myDeck(cardDeck, showBack),
    );
  }
}
