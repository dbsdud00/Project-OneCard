import 'package:flutter/material.dart';
import 'package:onecard/model/card_style.dart';
import 'package:onecard/module/btn_elevated.dart';
import 'package:playing_cards/playing_cards.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // This style object overrides the styles for spades.

  List<PlayingCard> deck = standardFiftyFourCardDeck();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/MainPage_bg.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 255, 193, 7),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 100,
                width: 400,
                child: playerCardDeck(),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child: PlayingCardView(
                        card: PlayingCard(Suit.spades, CardValue.ace),
                        showBack: true,
                        elevation: 3.0,
                        shape: shape,
                        style: myCardStyles,
                      ),
                    ),
                    elevatedBtn(context,
                        btnText: "OneCard", width: 180, fontSize: 20),
                    SizedBox(
                      height: 100,
                      child: PlayingCardView(
                        card: PlayingCard(Suit.joker, CardValue.joker_1),
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
                child: playerCardDeck(),
              )
            ],
          ),
        ),
      ),
    );
  }

  FlatCardFan playerCardDeck() {
    return FlatCardFan(children: [
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.hearts, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.hearts, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.hearts, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.hearts, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.spades, CardValue.ace),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
      PlayingCardView(
        card: PlayingCard(Suit.joker, CardValue.joker_2),
        // showBack: true,
        elevation: 3.0,
        shape: shape,
        style: myCardStyles,
      ),
    ]);
  }
}
