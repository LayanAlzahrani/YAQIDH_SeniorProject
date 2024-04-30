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
      toastification.showError(
        icon: const Icon(Icons.error_outline),
        description: e.message ?? "Opps",
        context: context,
        title: 'Something went wrong!',
        autoCloseDuration: const Duration(seconds: 5),
      );
    }

    await app.delete();
    return Future.sync(() => user);
  }

  // static Future<void> sendNotification(String id, String content) async {
  //   try {
  //     await Dio(BaseOptions(headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'Basic MzY5YWUxYzEtNDZmNC00MDYwLWI0MGEtNTljNmI1MDU0MmFj',
  //     })).post(
  //       'https://onesignal.com/api/v1/notifications',
  //       data: {
  //         'android_sound': "default",
  //         'app_id': "bc1ec00d-aaf9-49df-9cfc-a5376393ed70",
  //         "include_external_user_ids": [id], //for testing purposes
  //         "data": {"en": "EN"},
  //         "contents": {"en": "$content"},
  //         "headings": {"en": "Notification"},
  //       },
  //     );
  //   } on DioException catch (e) {
  //     print(e.response);
  //   }
  // }

  static void restPassword(BuildContext context, String email) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
                Text(
                  "Are you sure you want\nto reset password for",
                  style: const TextStyle(
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
              Divider(
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
      toastification.showError(
        icon: const Icon(Icons.error_outline),
        description: "${e.toString()}",
        context: context,
        title: 'something went wrong!',
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
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        toastification.showError(
          icon: const Icon(Icons.error_outline),
          description: 'Please check your login credentials',
          context: context,
          title: 'Sorry!',
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else if (e.code == 'wrong-password') {
        toastification.showError(
          icon: const Icon(Icons.error_outline),
          description: 'Incorrect password',
          context: context,
          title: 'Sorry!',
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else {
        toastification.showError(
          icon: const Icon(Icons.error_outline),
          description: e.message ?? "Opps",
          context: context,
          title: 'Something went wrong!',
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    }

    return user;
  }
}
