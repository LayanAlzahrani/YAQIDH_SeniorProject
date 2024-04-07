// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens//Admin/myaccount.dart';
import 'package:yaqidh_first/Screens//Admin/studentss_list.dart';
import 'package:yaqidh_first/Widgets/customBottomNavigationBar.dart';
import 'package:yaqidh_first/Widgets/listWidget.dart';
import 'package:yaqidh_first/Widgets/studentNameListWidget.dart';
import 'package:yaqidh_first/Widgets/teacherNameWidget.dart';
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'الرئيسية',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF365486),
      ),
      body: Container(
        height: double.infinity,
        color: Color(0xFFF8F8F8),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: screenHeight * 0.02),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListWidget(
                    imgUrl:
                        'https://drive.google.com/uc?export=view&id=1VS5pzOzvOPWrLOR3JNkEp9MC9nplBHPW',
                    fieldName: 'قائمة المعلمين',
                    ontap: () {},
                  ),
                  SizedBox(width: screenWidth * 0.035),
                  ListWidget(
                    imgUrl:
                        'https://drive.google.com/uc?export=view&id=1rfPcVZwuBt0pHf9vfvM4OkE4ZJvCqDVQ',
                    fieldName: 'قائمة الطلاب',
                    ontap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentListPage()),
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.022,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ":الطلاب المُضافين مؤخرًا",
                    style: TextStyle(
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            NameListWidget(),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ":المعلمين المُضافين مؤخرًا",
                    style: TextStyle(
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TeacherNameListWidget(),
            SizedBox(
              height: screenHeight * 0.02,
            )
          ]),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index != 0) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MyAccount()),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
