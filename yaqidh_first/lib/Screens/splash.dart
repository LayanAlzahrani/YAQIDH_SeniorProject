import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/homepage.dart';
import 'package:yaqidh_first/Screens/Admin/login.dart';
import 'package:yaqidh_first/Screens/Teacher/homepage_T.dart';

class SplashScreen extends StatefulWidget {
  final SplashScreenModel model;
  const SplashScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4, milliseconds: 500))
        .then((value) => checkRoleAndNavigate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeaeaea),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(child: CircularProgressIndicator()),
        ));
  }

  Future<void> checkRoleAndNavigate() async {
    final Role role = await widget.model.init();
    if (role == Role.noUser) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    } else if (role == Role.teacher) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePageTeacher()));
    } else if (role == Role.admin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }
}

class SplashScreenModel {
  //as it takes little time to check no need timer
  Future<Role> init() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final role = snap['userType'];
      if (role == 'teacher') {
        return Role.teacher;
      } else if (role == 'admin') {
        return Role.admin;
      } else {
        return Role.noUser;
      }
    } else {
      return Role.noUser;
    }
  }
}

enum Role { admin, teacher, noUser }
