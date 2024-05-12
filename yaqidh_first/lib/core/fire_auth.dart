// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:yaqidh_first/Screens/Admin/login.dart';
import 'package:yaqidh_first/Screens/splash.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(
        displayName: name,
      );
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> register(
      String email, String password, BuildContext context) async {
    User? user;
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      toastification.show(
        icon: const Icon(Icons.error_outline),
        description: Text(e.message ?? "Opps"),
        context: context,
        title: const Text('Something went wrong!'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }

    await app.delete();
    return Future.sync(() => user);
  }

  static void restPassword(BuildContext context, String email) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Color(0xFF7FC7D9),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Are you sure you want\nto reset password for",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
            actions: [
              TextButton(
                child: const Center(
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 3, 69, 2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
              const Divider(
                color: Colors.black,
                thickness: 1.0,
                indent: 0.5,
                endIndent: 0.5,
              ),
              TextButton(
                child: const Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 3, 69, 2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email);
                  Navigator.pop(context);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          );
        },
      );
    } catch (e) {
      toastification.show(
        icon: const Icon(Icons.error_outline),
        description: Text(e.toString()),
        context: context,
        title: const Text('something went wrong!'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  static void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SplashScreen(
          model: SplashScreenModel(),
        ),
      ),
    );
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SplashScreen(model: SplashScreenModel())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
          toastification.show(
            icon: const Icon(Icons.error_outline),
            description: const Text('يرجى التحقق من البريد الإلكتروني'),
            context: context,
            title: const Text('عذرًا!'),
            autoCloseDuration: const Duration(seconds: 5),
          );
        
      } else if (e.code == 'wrong-password') {
        toastification.show(
          icon: const Icon(Icons.error_outline),
            description: const Text('يوجد خطأ في كلمة المرور'),
            context: context,
            title: const Text('عذرًا!'),
            autoCloseDuration: const Duration(seconds: 5),
          );
      } else {
        toastification.show(
          icon: const Icon(Icons.error_outline),
          description: const Text("!يُرجى المحاولة مرة أخرى"),
          context: context,
          title: const Text('حدث خطأ غير متوقع'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    }

    return user;
  }
}
