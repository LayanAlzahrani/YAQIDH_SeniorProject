// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Widgets/pdf_widget.dart';
import 'package:yaqidh_first/Widgets/profile_info.dart';
import 'package:yaqidh_first/Widgets/settingsWidget.dart';
import 'package:yaqidh_first/firebase_options.dart';

import 'student_list_T.dart';

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
      home: const StudentProfileForTeacher(),
    );
  }
}

class StudentProfileForTeacher extends StatefulWidget {
  const StudentProfileForTeacher({Key? key}) : super(key: key);

  @override
  State<StudentProfileForTeacher> createState() =>
      _StudentProfileForTeacherState();
}

class _StudentProfileForTeacherState extends State<StudentProfileForTeacher> {
  final pdfw = PdfWidget();
  final double coverHeight = 85;
  final double profileHeight = 98;

  //function to edit fields
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
              MaterialPageRoute(builder: (context) => StudentListTeacher()),
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
                    "إسم الطالب",
                    style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  ProfileInfo(
                    sectionName: 'رقم التعريف',
                    info: '200000',
                    onPressed: () {},
                  ),
                  ProfileInfo(
                    sectionName: 'تاريخ الميلاد',
                    info: '12-3-2018',
                    onPressed: () {},
                  ),
                  ProfileInfo(
                    sectionName: 'رقم هاتف ولي الأمر',
                    info: '0543278484',
                    onPressed: () {},
                  ),
                  ProfileInfo(
                    sectionName: 'البريد الإلكتروني لـ ولي الأمر',
                    info: 'Parent@gmail.com',
                    onPressed: () {},
                  ),
                  ProfileInfo(
                    sectionName: 'تاريخ التشخيص',
                    info: '22-6-2023',
                    onPressed: () {},
                  ),
                  ProfileInfo(
                    sectionName: 'المسؤول عن التشخيص',
                    info: 'أ. ريم احمد',
                    onPressed: () {},
                  ),
                  SettingsWidget(
                      name: 'التقرير',
                      ontap: () async {
                        final data = await pdfw.generatePDF();
                        await pdfw.savePdfFile("ADHD_Report", data);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        tooltip: 'edit',
        backgroundColor: Color(0xFF7FC7D9),
        foregroundColor: Colors.white,
        elevation: screenHeight * 0.002,
        child: Icon(
          FontAwesomeIcons.pen,
          size: screenHeight * 0.025,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
