class HexColor {
  static int intFromHex(String hexColor) {
    return int.parse(hexColor.replaceAll('#', '0xff'));
  }
}
