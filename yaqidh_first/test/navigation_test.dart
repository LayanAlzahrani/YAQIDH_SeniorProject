import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/Screens/splash.dart';
import 'package:yaqidh_first/main.dart';

void main() {
  test('FirstPage navigation test', () {
    const firstPage = FirstPage();

    expect(firstPage, isNotNull);

    Future.delayed(const Duration(milliseconds: 4000), () {
      final splashScreen = SplashScreen(model: SplashScreenModel());
      expect(splashScreen, isNotNull);
    });
  });
}
