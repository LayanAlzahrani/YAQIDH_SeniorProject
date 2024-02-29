// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/student_profile.dart';
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
      home: Report(),
    );
  }
}

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft,
              color: Colors.white), // Set icon color to white
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) =>
                      StudentProfile()), // Navigate to MyAccount()
            );
          },
        ),

        //elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'التقرير',
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
            children: [],
          ),
        ),
      ),
    );
  }
}
