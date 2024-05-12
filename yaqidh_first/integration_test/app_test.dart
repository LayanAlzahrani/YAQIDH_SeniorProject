import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yaqidh_first/Screens/Admin/homepage.dart';
import 'package:yaqidh_first/Screens/Admin/login.dart' as app;
import 'package:yaqidh_first/Screens/Admin/login.dart';
import 'package:yaqidh_first/Screens/splash.dart';
import 'package:yaqidh_first/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:yaqidh_first/core/fire_auth.dart'; // Ensure the correct import

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  group('end to end test', () {
    testWidgets('verify login screen with correct email and password', (tester) async {
      await tester.pumpWidget(ToastificationWrapper(
        child: MaterialApp(
          home: app.LoginPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(Key('emailTextField')),
        'yaqidhsp@gmail.com',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.enterText(
        find.byKey(Key('passwordTextField')),
        'Ya1234',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.text('تسجيل'));
      await tester.pumpAndSettle();

      // Uncomment the line below if you want to assert for navigation to HomePage
      //expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('verify login screen with correct email and incorrect password', (tester) async {
      await tester.pumpWidget(ToastificationWrapper(
        child: MaterialApp(
          home: app.LoginPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(Key('emailTextField')),
        'yaqidhsp@gmail.com',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.enterText(
        find.byKey(Key('passwordTextField')),
        'Ya1266',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.text('تسجيل'));
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 5)); // Extra wait to ensure async completion
      expect(find.text('يوجد خطأ في كلمة المرور'), findsOneWidget);
    });

    testWidgets('verify login screen with incorrect email and correct password', (tester) async {
      await tester.pumpWidget(ToastificationWrapper(
        child: MaterialApp(
          home: app.LoginPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(Key('emailTextField')),
        'yaqidh44@gmail.com',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.enterText(
        find.byKey(Key('passwordTextField')),
        'Ya1234',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.text('تسجيل'));
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 5)); // Extra wait to ensure async completion
      expect(find.text('يرجى التحقق من البريد الإلكتروني'), findsOneWidget);
    });
  });
}