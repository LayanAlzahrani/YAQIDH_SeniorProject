// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Teacher/homepage_T.dart';
import 'package:yaqidh_first/Screens/Teacher/my_account_T.dart';
import 'package:yaqidh_first/Screens/Teacher/student_selection.dart';
import 'package:yaqidh_first/Widgets/button_widget2.dart';
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
      home: Game(),
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    //double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        //elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'اللعبة',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF365486),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF8F8F8),
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.022),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(height: screenHeight * 0.01),
            Text(
              "هل أنت مستعد لاختبار الطلاب؟",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: screenHeight * 0.017, fontWeight: FontWeight.bold),
            ),
            Text(
              "قبل بدء الاختبار، يجب عليك اتباع الخطوات التالية:",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: screenHeight * 0.016),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              "1. اختيار طالب أو مجموعة من الطلاب\n"
              "2. النقر على زر إنشاء\n"
              "3. سيتم إنشاء رمز فريد لكل طالب\n"
              "4. يجب عليك إدخال هذا الرمز داخل لعبة ‘يقظ’ لبدء الاختبار واختبار الطالب",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: screenHeight * 0.016),
            ),
            SizedBox(height: screenHeight * 0.047),
            Text(
              "إذا كنت مستعدًا، يُرجى النقر على الزر أدناه",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: screenHeight * 0.016, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.027),
            MyButton2(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => StudentSelection()),
                );
              },
              buttonName: 'ابدأ',
            ),
          ]),
        ),
      ),
      bottomNavigationBar: TeacherNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 2) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MyAccountTeacher()),
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
}
