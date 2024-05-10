// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/assigned_stud_A.dart';
import 'package:yaqidh_first/Widgets/profile_info.dart';
import 'package:yaqidh_first/Widgets/settingsWidget.dart';
import 'package:yaqidh_first/core/db.dart';
import 'package:yaqidh_first/firebase_options.dart';

void main() async {
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
      home: const TeacherProfile(
        teacherId: '',
      ),
    );
  }
}

class TeacherProfile extends StatefulWidget {
  final String teacherId;

  const TeacherProfile({super.key, required this.teacherId});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  final double coverHeight = 85;
  final double profileHeight = 98;

  final userCollection = FirebaseFirestore.instance.collection('users');

  List<Map<String, dynamic>> _teachers = [];

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  FirestoreOperationsProxy proxy = FirestoreOperationsProxy();

  Future<void> _fetchTeachers() async {
    try {
      final teachers = await proxy.getAllTeachers();
      setState(() {
        _teachers = teachers;
      });
      print('_teachers: $_teachers');
    } catch (error) {
      print('Error fetching teachers: $error');
    }
  }

  Future<void> editField(String field, String teacherId) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Edit $field",
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: TextStyle(color: Colors.grey)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('cancel')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: Text('save'))
        ],
      ),
    );
    // Update in firestore
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(teacherId).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    var teacher = _teachers.isNotEmpty
        ? _teachers.firstWhere((teacher) => teacher['id'] == widget.teacherId)
        : null;

    if (teacher == null) {
      return Center(
          child: CircularProgressIndicator(
        color: Color(0xFF7FC7D9),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // Change the icon here
            color: Colors.white, // Change the color here
          ),
          onPressed: () {
            Navigator.pop(context);
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
                  InkWell(
                    onTap: () => editField('name', teacher['id']),
                    child: Text(
                      teacher['name'],
                      style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  ProfileInfo(
                    sectionName: 'رقم التعريف',
                    info: teacher['TId'],
                    Align: MainAxisAlignment.end,
                  ),
                  ProfileInfo(
                    sectionName: 'البريد الإلكتروني',
                    info: teacher['email'],
                    icon: InkWell(
                      onTap: () => editField('email', teacher['id']),
                      child: Icon(
                        Icons.settings,
                        size: screenHeight * 0.021,
                        color: Color.fromARGB(255, 179, 178, 178),
                      ),
                    ),
                    Align: MainAxisAlignment.spaceBetween,
                  ),
                  ProfileInfo(
                    sectionName: 'رقم الهاتف',
                    info: teacher['phone'],
                    icon: InkWell(
                      onTap: () => editField('phone', teacher['id']),
                      child: Icon(
                        Icons.settings,
                        size: screenHeight * 0.021,
                        color: Color.fromARGB(255, 179, 178, 178),
                      ),
                    ),
                    Align: MainAxisAlignment.spaceBetween,
                  ),
                  SettingsWidget(
                    name: 'قائمة الطلاب المسؤول عنهم',
                    ontap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              AssignedStudentsA(teacherId: teacher['id'])),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildContent() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           "إسم الإداري",
  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 14,
  //         ),
  //         ProfileInfo(),
  //       ],
  //     ),
  //   );
  // }

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
