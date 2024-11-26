import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';

void main() {
  group('HexColor', () {
    test('handles hash prefixed strings correctly', () {
      expect(HexColor.intFromHex('#FFFFFF'), 0xFFFFFFFF);
    });
  });
}
