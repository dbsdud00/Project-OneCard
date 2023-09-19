// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:playing_cards/playing_cards.dart';

class CardDto {
  PlayingCard card;
  bool avalCard;
  bool isAtack;

  // Creates a playing card.
  CardDto({required this.card, this.avalCard = false, this.isAtack = false});
}
