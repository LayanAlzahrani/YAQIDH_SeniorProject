// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Widgets/all_student_list_T.dart';
import 'package:yaqidh_first/Widgets/search_widget.dart';
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
      home: StudentListTeacher(),
    );
  }
}

class StudentListTeacher extends StatefulWidget {
  const StudentListTeacher({Key? key}) : super(key: key);

  @override
  State<StudentListTeacher> createState() => _StudentListTeacherState();
}

class _StudentListTeacherState extends State<StudentListTeacher> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) => HomePageTeacher()),
            // );
          },
        ),
        title: Text(
          'قائمة الطلاب',
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
            SearchWidget(),
            AllStudentNamesForTeacher(),
          ]),
        ),
      ),
    );
  }
}
