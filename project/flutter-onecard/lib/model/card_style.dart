import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(
  suitStyles: {
    Suit.spades: SuitStyle(
        builder: (context) => Image.asset("images/spade.png"),
        cardContentBuilders: {
          CardValue.jack: (context) => Image.asset("images/jack-black.png"),
          CardValue.queen: (context) => Image.asset("images/queen-black.png"),
          CardValue.king: (context) => Image.asset("images/king-black.png"),
        }),
    Suit.diamonds: SuitStyle(
        builder: (context) => Image.asset("images/diamond.png"),
        cardContentBuilders: {
          CardValue.jack: (context) => Image.asset("images/jack-color.png"),
          CardValue.queen: (context) => Image.asset("images/queen-color.png"),
          CardValue.king: (context) => Image.asset("images/king-color.png"),
        }),
    Suit.hearts: SuitStyle(
        builder: (context) => Image.asset("images/heart.png"),
        cardContentBuilders: {
          CardValue.jack: (context) => Image.asset("images/jack-color.png"),
          CardValue.queen: (context) => Image.asset("images/queen-color.png"),
          CardValue.king: (context) => Image.asset("images/king-color.png"),
        }),
    Suit.clubs: SuitStyle(
        builder: (context) => Image.asset("images/clover.png"),
        cardContentBuilders: {
          CardValue.jack: (context) => Image.asset("images/jack-black.png"),
          CardValue.queen: (context) => Image.asset("images/queen-black.png"),
          CardValue.king: (context) => Image.asset("images/king-black.png"),
        }),
    Suit.joker: SuitStyle(
      style: const TextStyle(fontSize: 20),
      cardContentBuilders: {
        CardValue.joker_2: (context) => Image.asset("images/joker_color.png"),
        CardValue.joker_1: (context) => Image.asset("images/joker_black.png")
      },
    )
  },
);

ShapeBorder shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(4),
  side: const BorderSide(color: Color.fromARGB(255, 137, 137, 137), width: 1),
);
ShapeBorder avalShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(4),
  side: const BorderSide(color: Color.fromARGB(255, 247, 46, 46), width: 1),
);
