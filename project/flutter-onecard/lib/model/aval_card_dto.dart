// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:playing_cards/playing_cards.dart';

class AvalCardDto {
  PlayingCard card;
  int index;

  // Creates a playing card.
  AvalCardDto({required this.card, required this.index});

  @override
  String toString() => 'AvalCardDto(card: $card, index: $index)';
}
