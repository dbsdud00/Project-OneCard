import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onecard/model/aval_card_dto.dart';
import 'package:onecard/model/card_style.dart';
import 'package:onecard/model/card_dto.dart';
import 'package:onecard/model/user.dart';
import 'package:onecard/module/btn_elevated_func.dart';
import 'package:onecard/module/game_helper.dart';
import 'package:onecard/module/on_back_key.dart';
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

  List<CardDto> playerDeck = [];
  List<CardDto> computerDeck = [];
  List<CardDto> gameDeck = [];
  List<CardDto> drawDeck = [];
  List<AvalCardDto> computerAvalDeck = [];
  List<AvalCardDto> playerAvalDeck = [];

  bool attackMode = false;
  int attackStack = 0;
  bool turn = true;
  bool gameEnd = false;
  bool playerTurn = false;
  bool computerTurn = false;

  late Timer _timer;
  int seconds = 20;
  bool isRunning = false;
  void _startTimer() {
    if (!isRunning) {
      isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (seconds > 0) {
            seconds--;
          } else {
            playerTurn = false;
            if (drawDeck.isEmpty) {
              GameHelper().drawCardInDeck(
                  deck: deck, targetDeck: playerDeck, gameDeck: gameDeck);
            }
            _stopTimer();
          }
        });
      });
    }
  }

  void _stopTimer() {
    isRunning = false;
    _timer.cancel();

    drawDeck = [];
    playerTurn = false;
    seconds = 20;
    setState(() {});
  }

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
    playerTurn = turn;
    super.initState();
    debugPrint("누가먼저? $turn");
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 2000), () {
      try {
        avalCardRendering(playerDeck: playerDeck, showBack: false);
        avalCardRendering(playerDeck: computerDeck, showBack: true);
        if (playerTurn) {
          _startTimer();
        } else {
          _stopTimer();
          debugPrint("컴퓨터 턴");

          if (computerAvalDeck.isEmpty) {
            if (drawDeck.isEmpty) {
              GameHelper().drawCardInDeck(
                  deck: deck, targetDeck: computerDeck, gameDeck: gameDeck);
            }
            drawDeck = [];
            playerTurn = true;
          } else {
            avalCardRendering(playerDeck: computerDeck, showBack: true);
            debugPrint("컴퓨터 낼수있는 카드 개수 : ${computerAvalDeck.length}");
            for (int i = 0; i < computerAvalDeck.length; i++) {
              debugPrint(
                  "컴퓨터가 낼수있는 카드 : ${computerAvalDeck[i].card.suit.toString().split(".")[1]}/${computerAvalDeck[i].card.value.toString().split(".")[1]}");
            }
            int cNum = Random().nextInt(computerAvalDeck.length) + 1;
            debugPrint(
                "컴퓨터 선택한 카드 : ${computerAvalDeck[cNum].card.suit}/${computerAvalDeck[cNum].card.value.toString().split(".")[1]}");
            drawDeck.add(computerDeck[computerAvalDeck[cNum].index]);
            gameDeck.add(computerDeck.removeAt(computerAvalDeck[cNum].index));
            computerAvalDeck = [];
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
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
                  height: 150,
                  width: 400,
                  child: playerCardDeck(computerDeck, true),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: drawDeck.isEmpty
                            ? () {}
                            : () {
                                GameHelper().drawCardInDeck(
                                    deck: deck,
                                    targetDeck: playerDeck,
                                    gameDeck: gameDeck);

                                setState(() {
                                  playerTurn = false;
                                  _stopTimer();
                                });
                              },
                        child: SizedBox(
                          height: 150,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('$seconds',
                              style: const TextStyle(fontSize: 40)),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ElevatedButton(
                              onPressed: isRunning
                                  ? () {
                                      if (drawDeck.isEmpty) {
                                        GameHelper().drawCardInDeck(
                                            deck: deck,
                                            targetDeck: playerDeck,
                                            gameDeck: gameDeck);
                                      }
                                      _stopTimer();
                                    }
                                  : null,
                              child: const Text('턴 넘기기'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150,
                        child: PlayingCardView(
                          card: gameDeck[gameDeck.length - 1].card,
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
                  height: 150,
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

  List<Widget> myDeck({
    required List<CardDto> playerDeck,
    required bool showBack,
    required List<CardDto> boardDeck,
  }) {
    List<Widget> cardWidgetList = [];
    avalCardRendering(playerDeck: playerDeck, showBack: showBack);

    for (int i = 0; i < playerDeck.length; i++) {
      cardWidgetList.add(
        GestureDetector(
          onTap: !playerDeck[i].avalCard || showBack || !playerTurn
              ? () {}
              : () {
                  debugPrint("카드 클릭함");

                  CardDto selectCard = playerDeck[i];
                  boardDeck.add(playerDeck.removeAt(i));
                  for (int a = 0; a < playerDeck.length; a++) {
                    playerDeck[a].avalCard = false;
                  }
                  drawDeck.add(selectCard);
                  setState(() {});
                },
          child: Container(
            decoration: !playerDeck[i].avalCard // || showBack
                ? null
                : BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 173, 173, 173)
                            .withOpacity(1),
                        blurRadius: 7.0,
                        spreadRadius: 1.0,
                        offset: const Offset(-3, 7),
                      )
                    ],
                    // color: const Color.fromARGB(255, 163, 132, 132),
                  ),
            child: PlayingCardView(
              card: PlayingCard(
                  playerDeck[i].card.suit, playerDeck[i].card.value),
              showBack: showBack,
              elevation: !playerDeck[i].avalCard || showBack ? 3 : 20,
              shape: !playerDeck[i].avalCard || showBack ? shape : avalShape,
              style: myCardStyles,
            ),
          ),
        ),
      );
    }

    return cardWidgetList;
  }

  void avalCardRendering({
    required List<CardDto> playerDeck,
    required bool showBack,
  }) {
    for (int i = 0; i < playerDeck.length; i++) {
      int gameCardValue = GameHelper().stringToNumber(
          gameDeck[gameDeck.length - 1].card.value.toString().split(".")[1]);
      String gameCardSuit =
          gameDeck[gameDeck.length - 1].card.suit.toString().split(".")[1];
      int myCardValue = GameHelper()
          .stringToNumber(playerDeck[i].card.value.toString().split(".")[1]);
      String myCardSuit = playerDeck[i].card.suit.toString().split(".")[1];
      // debugPrint("2222222222$myCardSuit");
      if (!attackMode) {
        if (gameCardValue == myCardValue) {
          playerDeck[i].avalCard = true;
        } else if (gameCardSuit == myCardSuit) {
          if (gameCardValue >= 100 ||
              myCardValue > 10 ||
              ((gameCardValue - myCardValue) >= -1 &&
                  (gameCardValue - myCardValue) <= 1) ||
              (gameCardValue >= 12 && gameCardValue <= 16)) {
            playerDeck[i].avalCard = true;
          }
        } else if (myCardValue == 500) {
          if (gameCardSuit == "clubs" || gameCardSuit == "spades") {
            playerDeck[i].avalCard = true;
          }
        } else if (myCardValue == 700) {
          if (gameCardSuit == "hearts" || gameCardSuit == "diamonds") {
            playerDeck[i].avalCard = true;
          }
        } else if (gameCardValue == 500) {
          if (myCardSuit == "clubs" || myCardSuit == "spades") {
            playerDeck[i].avalCard = true;
          }
        } else if (gameCardValue == 700) {
          if (myCardSuit == "hearts" || myCardSuit == "diamonds") {
            playerDeck[i].avalCard = true;
          }
        } else {
          playerDeck[i].avalCard = false;
        }
      } else {
        // attack mode
        if (gameCardValue == myCardValue) {
          playerDeck[i].avalCard = true;
        } else if (gameCardSuit == myCardSuit) {
          if (gameCardValue <= myCardValue) {
            playerDeck[i].avalCard = true;
          }
        } else {
          playerDeck[i].avalCard = false;
        }
      }
      if (showBack) {
        if (playerDeck[i].avalCard) {
          AvalCardDto temp = AvalCardDto(card: playerDeck[i].card, index: i);
          computerAvalDeck.add(temp);
        }
      } else {
        if (playerDeck[i].avalCard) {
          AvalCardDto temp = AvalCardDto(card: playerDeck[i].card, index: i);
          playerAvalDeck.add(temp);
        }
      }
    }
  }

  Widget playerCardDeck(List<CardDto> cardDeck, bool showBack) {
    return FlatCardFan(
      children:
          myDeck(playerDeck: cardDeck, showBack: showBack, boardDeck: gameDeck),
    );
  }
}
