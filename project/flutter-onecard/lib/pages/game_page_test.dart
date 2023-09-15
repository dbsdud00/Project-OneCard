import 'package:flutter/material.dart';
import 'package:onecard/model/card_style.dart';
import 'package:playing_cards/playing_cards.dart';

class GamePageTest extends StatefulWidget {
  const GamePageTest({super.key});

  @override
  State<GamePageTest> createState() => _GamePageTestState();
}

class _GamePageTestState extends State<GamePageTest> {
  // This style object overrides the styles for spades.

  List<PlayingCard> deck = standardFiftyFourCardDeck();

  @override
  Widget build(BuildContext context) {
    deck.shuffle();
    PlayingCard first = deck.removeAt(0);
    List<PlayingCard> playerDeck = [];
    for (int i = 0; i < 7; i++) {
      playerDeck.add(deck.removeAt(0));
    }
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/MainPage_bg.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 255, 193, 7),
        body: Column(
          children: [
            Center(
              child: SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: deck
                        .map((e) =>
                            PlayingCardView(card: e, style: myCardStyles))
                        .toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: 300,
                child: PlayingCardView(
                  card: first,
                  style: myCardStyles,
                )),
            SizedBox(
              height: 100,
              width: 400,
              child: FlatCardFan(children: [
                PlayingCardView(
                  card: playerDeck[0],
                  // showBack: true,
                  elevation: 3.0,
                  shape: shape,
                  style: myCardStyles,
                ),
                PlayingCardView(
                  card: playerDeck[1],
                  // showBack: true,
                  elevation: 3.0,
                  shape: shape,
                  style: myCardStyles,
                ),
                PlayingCardView(
                  card: playerDeck[2],
                  // showBack: true,
                  elevation: 3.0,
                  shape: shape,
                  style: myCardStyles,
                ),
                PlayingCardView(
                  card: playerDeck[3],
                  elevation: 3.0,
                  shape: shape,
                  style: myCardStyles,
                ),
                PlayingCardView(
                  card: playerDeck[4],
                  // showBack: true,
                  elevation: 3.0,
                  shape: shape,
                  style: myCardStyles,
                ),
                PlayingCardView(
                  card: playerDeck[5],
                  // showBack: true,
                  elevation: 3.0,
                  shape: shape,
                  style: myCardStyles,
                ),
                PlayingCardView(
                  card: playerDeck[6],
                  // showBack: true,
                  elevation: 3.0,
                  shape: shape,
                  style: myCardStyles,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
