// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Widgets/pdf_widget.dart';
import 'package:yaqidh_first/Widgets/profile_info.dart';
import 'package:yaqidh_first/Widgets/settingsWidget.dart';
import 'package:yaqidh_first/core/db.dart';
import 'package:intl/intl.dart';

class StudentProfile extends StatefulWidget {
  final String studentId;

  const StudentProfile({super.key, required this.studentId});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final pdfw = PdfWidget();
  final double coverHeight = 85;
  final double profileHeight = 98;

  final userCollection = FirebaseFirestore.instance.collection('students');

  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  FirestoreOperationsProxy proxy = FirestoreOperationsProxy();

  Future<void> _fetchStudents() async {
    try {
      final students = await proxy.getAllStudents();
      setState(() {
        _students = students;
      });
      print('_students: $_students');
    } catch (error) {
      print('Error fetching students: $error');
    }
  }

  //function to edit fields
  Future<void> editField(String field, String studentId) async {
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
      await userCollection.doc(studentId).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    var student = _students.isNotEmpty
        ? _students.firstWhere((student) => student['id'] == widget.studentId)
        : null;

    if (student == null) {
      return Center(
          child: CircularProgressIndicator(
        color: Color(0xFF7FC7D9),
      ));
    }

    final timestamp = student['age'] as Timestamp?;
    String formattedDate = '';

    if (timestamp != null) {
      final dateTime = timestamp.toDate();
      formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    }

    final timestamp2 = student['dateOfTest'] as Timestamp?;
    String formattedTestDate = '';

    if (timestamp2 != null) {
      final dateTime2 = timestamp2.toDate();
      formattedTestDate = DateFormat('yyyy-MM-dd').format(dateTime2);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
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
                    onTap: () => editField('fullName', student['id']),
                    child: Text(
                      student['fullName'],
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  ProfileInfo(
                    sectionName: 'رقم التعريف',
                    info: student['id'],
                    Align: MainAxisAlignment.end,
                  ),
                  ProfileInfo(
                    sectionName: 'رمز دخول الاختبار',
                    info: student['code'],
                    Align: MainAxisAlignment.end,
                  ),
                  ProfileInfo(
                    sectionName: 'تاريخ الميلاد',
                    info: formattedDate,
                    Align: MainAxisAlignment.end,
                  ),
                  ProfileInfo(
                    sectionName: 'رقم هاتف ولي الأمر',
                    info: student['phone'],
                    icon: InkWell(
                      onTap: () => editField('phone', student['id']),
                      child: Icon(
                        Icons.settings,
                        size: screenHeight * 0.021,
                        color: Color.fromARGB(255, 179, 178, 178),
                      ),
                    ),
                    Align: MainAxisAlignment.spaceBetween,
                  ),
                  StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return ProfileInfo(
                          sectionName: 'البريد الإلكتروني لـ ولي الأمر',
                          info: student['email'],
                          icon: InkWell(
                            onTap: () => editField('email', student['id']),
                            child: Icon(
                              Icons.settings,
                              size: screenHeight * 0.021,
                              color: Color.fromARGB(255, 179, 178, 178),
                            ),
                          ),
                          Align: MainAxisAlignment.spaceBetween,
                        );
                      }),
                  ProfileInfo(
                    sectionName: 'تاريخ التشخيص',
                    info: formattedTestDate,
                    Align: MainAxisAlignment.end,
                  ),
                  FutureBuilder(
                    future: (student['teacher'] as DocumentReference).get(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) return Container();

                      var teacher = (snapshot.data as DocumentSnapshot).data()
                          as Map<String, dynamic>;
                      return ProfileInfo(
                        sectionName: 'المسؤول عن التشخيص',
                        info: teacher['name'],
                        Align: MainAxisAlignment.end,
                      );
                    },
                  ),
                  SettingsWidget(
                    name: 'التقرير',
                    ontap: () async {
                      final data = await pdfw.generatePDF();
                      await pdfw.savePdfFile("ADHD_Report", data);
                    },
                  )
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
