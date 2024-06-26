// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/Teacher/my_account_T.dart';
import 'package:yaqidh_first/Widgets/profile_info.dart';
import 'package:yaqidh_first/firebase_options.dart';

void main() async {
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
      home: const TeacherMyProfile(),
    );
  }
}

class TeacherMyProfile extends StatefulWidget {
  const TeacherMyProfile({Key? key}) : super(key: key);

  @override
  State<TeacherMyProfile> createState() => _TeacherMyProfileState();
}

class _TeacherMyProfileState extends State<TeacherMyProfile> {
  final double coverHeight = 85;
  final double profileHeight = 95;

  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    //double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyAccountTeacher()),
            );
          },
        ),
        backgroundColor: Color(0xFF365486),
      ),
      body: Container(
        color: Color(0xFFF8F8F8),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "إسم المعلم",
                    style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  ProfileInfo(
                    sectionName: 'رقم التعريف',
                    info: '100000',
                  ),
                  ProfileInfo(
                    sectionName: 'البريد الإلكتروني',
                    info: 'Teacher@gmail.com',
                  ),
                  ProfileInfo(
                    sectionName: 'رقم الهاتف',
                    info: '0531324894',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2 + 18;
    final top = coverHeight - profileHeight / 2 - 10;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom), child: buildCoverImage()),
        Positioned(top: top, child: buildPFP())
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Color(0xFF365486), // Set the color here
        width: double.infinity,
        height: coverHeight - 10,
      );

  Widget buildPFP() => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFFF8F8F8), // Set border color
            width: profileHeight / 19, // Set border width
          ),
        ),
        child: CircleAvatar(
          radius: profileHeight / 2,
          // backgroundColor: Colors.grey.shade800,
          backgroundImage: NetworkImage(
            "https://drive.google.com/uc?export=view&id=1sE88XrMfk_xWqdSES3k3NVeEnpU70n1t",
          ),
        ),
      );
}
