class GameHelper {
  int stringToNumber(String strNum) {
    switch (strNum) {
      case "two":
        return 200;
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
        return 400;
      case "joker_1":
        return 500;
      case "joker_2":
        return 700;
      default:
        return 0;
    }
  }
}
