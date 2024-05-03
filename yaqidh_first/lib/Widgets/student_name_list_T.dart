// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/Teacher/student_profile_T.dart';
import 'package:yaqidh_first/core/db.dart';

class StudentNamesForTeacher extends StatefulWidget {
  const StudentNamesForTeacher({Key? key});

  @override
  State<StudentNamesForTeacher> createState() => _StudentNamesForTeacherState();
}

class _StudentNamesForTeacherState extends State<StudentNamesForTeacher> {
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

  void navigateToStudentProfile(String studentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentProfileForTeacher(studentId: studentId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final currentTeacherId = currentUser.uid;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .where(
              'teacherId',
              isEqualTo: currentTeacherId,
            )
            .orderBy('createdAt', descending: true)
            .limit(5)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              return InkWell(
                onTap: () {
                  navigateToStudentProfile(uid);
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
                      Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Color(0xFF7FC7D9),
                        size: 10,
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
    );
  }
}
