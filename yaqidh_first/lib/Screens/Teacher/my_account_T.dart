// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/admin_profile.dart';
import 'package:yaqidh_first/Screens/Admin/login.dart';
import 'package:yaqidh_first/Screens/Teacher/game.dart';
import 'package:yaqidh_first/Screens/Teacher/homepage_T.dart';
import 'package:yaqidh_first/Widgets/myaccWidget.dart';
import 'package:yaqidh_first/Widgets/settingsWidget.dart';
import 'package:yaqidh_first/Widgets/teacher_navigation_bar.dart';
import 'package:yaqidh_first/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Tajawal', useMaterial3: true),
      home: MyAccountTeacher(),
    );
  }
}

class MyAccountTeacher extends StatefulWidget {
  const MyAccountTeacher({Key? key}) : super(key: key);

  @override
  State<MyAccountTeacher> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccountTeacher> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        //elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'حسابي',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF365486),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
        color: const Color(0xFFF8F8F8),
        child: Center(
          child: Column(
            children: [
              MyAccWidget(),
              SettingsWidget(
                name: 'الإعدادات',
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminProfile()),
                  );
                },
              ),
              SettingsWidget(
                name: 'تسجيل الخروج',
                ontap: () {
                  signUserOut(context);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TeacherNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Game()),
              (route) => false,
            );
          } else if (index == 0) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePageTeacher()),
              (route) => false,
            );
          }
        },
      ),
    );
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }
}
