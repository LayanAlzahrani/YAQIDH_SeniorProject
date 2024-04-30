// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Teacher/game.dart';
import 'package:yaqidh_first/Screens/Teacher/my_account_T.dart';
import 'package:yaqidh_first/Screens/Teacher/student_list_T.dart';
import 'package:yaqidh_first/Widgets/list_widget_T.dart';
import 'package:yaqidh_first/Widgets/student_name_list_T.dart';
import 'package:yaqidh_first/Widgets/teacher_navigation_bar.dart';

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({Key? key}) : super(key: key);

  @override
  State<HomePageTeacher> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTeacher> {
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
            StudentListContainer(
              imgUrl:
                  'https://drive.google.com/uc?export=view&id=1rfPcVZwuBt0pHf9vfvM4OkE4ZJvCqDVQ',
              fieldName: '‹  قائمة الطلاب',
              ontap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudentListTeacher()),
                );
              },
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
                    ":الطلاب المُضافين لقائمتك مؤخرًا",
                    style: TextStyle(
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            StudentNamesForTeacher(),
          ]),
        ),
      ),
      bottomNavigationBar: TeacherNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 2) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MyAccountTeacher()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Game()),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
