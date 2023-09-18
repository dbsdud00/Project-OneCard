import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onecard/module/show_dialog.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:playing_cards/playing_cards.dart';

class GameHelper {
  int stringToNumber(String strNum) {
    switch (strNum) {
      case "two":
        return 2;
      case "three":
        return 3;
      case "four":
        return 4;
      case "five":
        return 5;
      case "six":
        return 6;
      case "seven":
        return 7;
      case "eight":
        return 8;
      case "nine":
        return 9;
      case "ten":
        return 10;
      case "jack":
        return 12;
      case "queen":
        return 14;
      case "king":
        return 16;
      case "ace":
        return 1;
      case "joker_1":
        return 500;
      case "joker_2":
        return 700;
      default:
        return 0;
    }
  }

  bool gameStart({
    required BuildContext context,
    required List<PlayingCard> deck,
    required List<PlayingCard> computerDeck,
    required List<PlayingCard> playerDeck,
    required List<PlayingCard> boardDeck,
    required String? nickname,
  }) {
    bool turn = true;
    deck.shuffle();
    boardDeck.add(deck.removeAt(0));
    boardDeck.add(deck.removeAt(0));

    Timer(const Duration(milliseconds: 0), () {
      showDialog(
        context: context,
        barrierColor: const Color.fromARGB(79, 255, 255, 255),
        barrierDismissible: true,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pop(context);
            showDialog(
              context: context,
              barrierColor: const Color.fromARGB(79, 255, 255, 255),
              barrierDismissible: true,
              builder: (context) {
                Future.delayed(const Duration(milliseconds: 500), () async {
                  Navigator.pop(context);
                  turn = await showDialogBasic(
                    context: context,
                    title: "주사위 굴리기",
                  );
                });
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
                          textValue: nickname ?? "Guest",
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

    return turn;
  }

  bool playerTurn({
    required List<PlayingCard> playerDeck,
    required List<PlayingCard> boardDeck,
    required int attackStack,
  }) {
    while (true) {
      for (int i = 0; i < playerDeck.length; i++) {
        int gameCardValue = GameHelper().stringToNumber(
            boardDeck[boardDeck.length - 1].value.toString().split(".")[1]);
        String gameCardSuit =
            boardDeck[boardDeck.length - 1].suit.toString().split(".")[1];
        int myCardValue = GameHelper()
            .stringToNumber(playerDeck[i].value.toString().split(".")[1]);
        String myCardSuit = playerDeck[i].suit.toString().split(".")[1];
        debugPrint("2222222222$myCardSuit");

        if (gameCardValue == myCardValue) {
          if (gameCardValue >= 100) {
            attackStack += (gameCardValue / 100).round();
          }
          boardDeck.add(playerDeck.removeAt(i));
        } else if (gameCardSuit == myCardSuit) {
          if (gameCardValue >= 100) {
            attackStack += (gameCardValue / 100).round();
            boardDeck.add(playerDeck.removeAt(i));
          } else if (myCardValue > 10) {
            boardDeck.add(playerDeck.removeAt(i));
          } else if ((gameCardValue - myCardValue) >= -1 &&
              (gameCardValue - myCardValue) <= 1) {
            boardDeck.add(playerDeck.removeAt(i));
          }
        } else if (myCardValue == 500) {
          if (gameCardSuit == "clubs" || gameCardSuit == "spades") {
            attackStack += 5;
            boardDeck.add(playerDeck.removeAt(i));
          }
        } else if (myCardValue == 700) {
          if (gameCardSuit == "hearts" || gameCardSuit == "diamonds") {
            attackStack += 7;
            boardDeck.add(playerDeck.removeAt(i));
          }
        }
        debugPrint(attackStack.toString());
      }
      break;
    }

    return true;
  }
}
