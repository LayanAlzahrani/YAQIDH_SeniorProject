// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/login.dart';
import 'package:yaqidh_first/Screens/Teacher/homepage_T.dart';
import 'package:yaqidh_first/Screens/Teacher/teacher_profile_T.dart';
import 'package:yaqidh_first/Widgets/customBottomNavigationBar.dart';
import 'package:yaqidh_first/Widgets/myaccWidget.dart';
import 'package:yaqidh_first/Widgets/settingsWidget.dart';
import 'package:yaqidh_first/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyAccountTeacher({super.key});

  @override
  State<MyAccountTeacher> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccountTeacher> {
  final currentUser = FirebaseAuth.instance.currentUser!;

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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
              color: const Color(0xFFF8F8F8),
              child: Center(
                child: Column(
                  children: [
                    MyAccWidget(
                      id: userData['TId'],
                      name: userData['name'],
                    ),
                    SettingsWidget(
                      name: 'الإعدادات',
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TeacherMyProfile()),
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
            );
          } else if (snapshot.hasError) {
            print('Error ${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF7FC7D9),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) {
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
