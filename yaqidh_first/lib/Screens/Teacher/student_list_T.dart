// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/Teacher/homepage_T.dart';
import 'package:yaqidh_first/Screens/Teacher/student_profile_T.dart';
import 'package:yaqidh_first/core/db.dart';
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
  final bool isTested = false;
  List<Map<String, dynamic>> _teachers = [];
  List<Map<String, dynamic>> _allStudents = [];
  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    try {
      final students = await YDB.getAllStudents();
      setState(() {
        _allStudents = students;
        _students = students;
      });
      print('_students: $_students');
    } catch (error) {
      print('Error fetching students: $error');
    }
  }

  void _filterStudents(String query) {
    if (query.isEmpty) {
      setState(() {
        _students = _allStudents;
      });
    } else {
      setState(() {
        _students = _allStudents.where((student) {
          final name = student['fullName'].toString().toLowerCase();
          final lowercaseQuery = query.toLowerCase();
          return name.contains(lowercaseQuery);
        }).toList();
      });
    }
  }

  Future<void> _fetchTeachers() async {
    try {
      final teachers = await YDB.getAllTeachers();
      setState(() {
        _teachers = teachers;
      });
      print('_teachers: $_teachers');
    } catch (error) {
      print('Error fetching teachers: $error');
    }
  }

  void navigateToStudentProfile(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentProfileForTeacher(
                  studentId: _students[index]['id'],
                )));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    final currentUser = FirebaseAuth.instance.currentUser!;
    final currentTeacherId = currentUser.uid;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageTeacher()),
          ),
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
            SearchWidget(onSearch: _filterStudents),
            SizedBox(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .where(
                      'teacherId',
                      isEqualTo: currentTeacherId,
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot document =
                          snapshot.data!.docs[index];
                      final data = document.data() as Map<String, dynamic>;
                      final uid = document.id;

                      final studentNumber = index + 1;

                      return InkWell(
                        onTap: () {
                          navigateToStudentProfile(index);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.015,
                            bottom: screenHeight * 0.015,
                            right: screenWidth * 0.015,
                            left: screenWidth * 0.01,
                          ),
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.013,
                            right: screenWidth * 0.038,
                            left: screenWidth * 0.038,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.grey[500],
                                  size: screenHeight * 0.02,
                                ),
                              ),
                              Container(
                                width: screenHeight * 0.1,
                                height: screenHeight * 0.029,
                                margin: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.01),
                                decoration: BoxDecoration(
                                  color: isTested
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                  borderRadius: BorderRadius.circular(
                                      screenHeight * 0.016),
                                ),
                                child: Center(
                                  child: Text(
                                    isTested
                                        ? "تم الاختبار"
                                        : "لم يتم الاختبار",
                                    style: TextStyle(
                                        color: isTested
                                            ? Colors.green[600]
                                            : Colors.red[600],
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight * 0.0123),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: screenHeight * 0.003),
                                    Text(
                                      uid,
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.014,
                                        color: const Color(0xFF999999),
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Text(
                                      data['fullName'],
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                '$studentNumber', // Display the student number
                                style: TextStyle(
                                  fontSize: screenHeight * 0.016,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchWidget({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.045, vertical: screenHeight * 0.01),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7FC7D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenHeight * 0.02),
              ),
            ),
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white,
              size: screenHeight * 0.02,
            ),
          ),
          SizedBox(width: screenWidth * 0.015),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * 0.02),
              ),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.00001),
              child: TextField(
                textAlign: TextAlign.right,
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: '...إبحث',
                  hintStyle: TextStyle(fontSize: screenHeight * 0.016),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
