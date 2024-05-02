import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/Admin/student_profile.dart';
import 'package:yaqidh_first/core/db.dart';

class AssignedStudentsA extends StatefulWidget {
  final String teacherId;

  const AssignedStudentsA({super.key, required this.teacherId});

  @override
  State<AssignedStudentsA> createState() => _AssignedStudentsAState();
}

class _AssignedStudentsAState extends State<AssignedStudentsA> {
  List<Map<String, dynamic>> _teachers = [];
  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
    _fetchStudents();
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

  Future<void> _fetchStudents() async {
    try {
      final students = await YDB.getAllStudents();
      setState(() {
        _students = students;
      });
      print('_students: $_students');
    } catch (error) {
      print('Error fetching students: $error');
    }
  }

  void navigateToStudentProfile(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentProfile(
                  studentId: _students[index]['id'],
                )));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الطلاب المسؤول عنهم',
          style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF365486),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        color: const Color(0xFFF8F8F8),
        child: SizedBox(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('students')
                .where(
                  'teacherId',
                  isEqualTo: widget.teacherId,
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  final DocumentSnapshot document = snapshot.data!.docs[index];
                  final data = document.data() as Map<String, dynamic>;
                  final uid = document.id;

                  final studentNumber = index + 1;

                  return InkWell(
                    onTap: () => navigateToStudentProfile(studentNumber),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.015,
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
                          SizedBox(width: screenWidth * 0.04),
                          Icon(
                            FontAwesomeIcons.chevronLeft,
                            color: Colors.grey[500],
                            size: screenHeight * 0.02,
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Container(
                            width: screenHeight * 0.1,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.012,
                              vertical: screenHeight * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: data['isTested']
                                  ? Colors.green[100]
                                  : Colors.red[100],
                              borderRadius:
                                  BorderRadius.circular(screenHeight * 0.016),
                            ),
                            child: Center(
                              child: Text(
                                data['isTested']
                                    ? "تم الاختبار"
                                    : "لم يتم الاختبار",
                                style: TextStyle(
                                    color: data['isTested']
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
      ),
    );
  }
}
