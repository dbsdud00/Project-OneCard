import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onecard/model/card_style.dart';
import 'package:onecard/model/user.dart';
import 'package:onecard/module/btn_elevated.dart';
import 'package:onecard/module/btn_elevated_func.dart';
import 'package:onecard/module/game_helper.dart';
import 'package:onecard/module/on_back_key.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:onecard/pages/main_page.dart';
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

  @override
  void initState() {
    deck.shuffle();
    Timer(const Duration(milliseconds: 0), () {
      showDialog(
        context: context,
        barrierColor: const Color.fromARGB(79, 255, 255, 255),
        barrierDismissible: true,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
            showDialog(
              context: context,
              barrierColor: const Color.fromARGB(79, 255, 255, 255),
              barrierDismissible: true,
              builder: (context) {
                Future.delayed(const Duration(seconds: 2), () {});
                return Dialog(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textOutline(
                          textValue: "COMPUTER",
                          fontSize: 40,
                          innerColor: const Color.fromARGB(255, 228, 146, 146),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: textOutline(
                              textValue: "VS",
                              fontSize: 60,
                              innerColor: Colors.amber),
                        ),
                        textOutline(
                          textValue: widget.player?.nickname ?? "unknown",
                          fontSize: 40,
                          innerColor: const Color.fromARGB(255, 157, 168, 243),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          });
          return Dialog(
            elevation: 0,
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textOutline(textValue: "CARSINO", fontSize: 60),
                  textOutline(
                      textValue: "ONECARD",
                      fontSize: 30,
                      innerColor: Colors.amber),
                ],
              ),
            ),
          );
        },
      );
    });

    for (int i = 0; i < 7; i++) {
      playerDeck.add(deck.removeAt(0));
    }
    for (int i = 0; i < 7; i++) {
      computerDeck.add(deck.removeAt(0));
    }
    gameDeck.add(deck.removeAt(0));
    super.initState();
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
                      elevatedBtn(context,
                          btnText: "OneCard", width: 180, fontSize: 20),
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
      cardWidgetList.add(GestureDetector(
        onTap: showBack
            ? () {}
            : () {
                // debugPrint(
                //     "1111111111${playerDeck.removeAt(i).suit.toString()}");
                int gameCardValue = GameHelper().stringToNumber(
                    gameDeck[gameDeck.length - 1]
                        .value
                        .toString()
                        .split(".")[1]);
                String gameCardSuit =
                    gameDeck[gameDeck.length - 1].suit.toString().split(".")[1];
                int myCardValue = GameHelper().stringToNumber(
                    playerDeck[i].value.toString().split(".")[1]);
                String myCardSuit = playerDeck[i].suit.toString().split(".")[1];
                debugPrint("2222222222$myCardSuit");

                if (gameCardValue == myCardValue) {
                  if (gameCardValue >= 100) {
                    attackStack += (gameCardValue / 100).round();
                  }
                  gameDeck.add(playerDeck.removeAt(i));
                } else if (gameCardSuit == myCardSuit) {
                  if (gameCardValue >= 100) {
                    attackStack += (gameCardValue / 100).round();
                    gameDeck.add(playerDeck.removeAt(i));
                  } else if (myCardValue > 10) {
                    gameDeck.add(playerDeck.removeAt(i));
                  } else if ((gameCardValue - myCardValue) >= -1 &&
                      (gameCardValue - myCardValue) <= 1) {
                    gameDeck.add(playerDeck.removeAt(i));
                  }
                } else if (myCardValue == 500) {
                  if (gameCardSuit == "clubs" || gameCardSuit == "spades") {
                    attackStack += 5;
                    gameDeck.add(playerDeck.removeAt(i));
                  }
                } else if (myCardValue == 700) {
                  if (gameCardSuit == "hearts" || gameCardSuit == "diamonds") {
                    attackStack += 7;
                    gameDeck.add(playerDeck.removeAt(i));
                  }
                }
                debugPrint(attackStack.toString());
                setState(() {});
              },
        child: PlayingCardView(
          card: playerDeck[i],
          showBack: showBack,
          elevation: 3.0,
          shape: shape,
          style: myCardStyles,
        ),
      ));
    }
    return cardWidgetList;
  }

  Widget playerCardDeck(List<PlayingCard> cardDeck, bool showBack) {
    return FlatCardFan(
      children: myDeck(cardDeck, showBack),
    );
  }
}
