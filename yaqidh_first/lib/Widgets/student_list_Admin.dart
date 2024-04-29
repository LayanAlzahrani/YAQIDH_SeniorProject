// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/student_profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/core/db.dart';

class StudentListForAdmin extends StatefulWidget {
  const StudentListForAdmin({Key? key}) : super(key: key);

  @override
  State<StudentListForAdmin> createState() => _StudentListForAdminState();
}

class _StudentListForAdminState extends State<StudentListForAdmin> {
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> _allStudents = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    try {
      final students = await YDB.getAllStudents();
      setState(() {
        _students = students;
        _allStudents = students;
      });
    } catch (error) {}
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    void _deleteStudent(String studentId) {
      YDB.deleteStudent(studentId).then((_) {
        setState(() {
          _students.removeWhere((student) => student['id'] == studentId);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('تم حذف الطالب بنجاح'),
        ));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('خطأ في حذف الطالب: $error'),
        ));
      });
    }

    Future<void> _showDeleteConfirmationDialog(
        BuildContext context, String studentId) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تأكيد الحذف'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('هل أنت متأكد أنك تريد حذف هذا الطالب؟'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('إلغاء'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('حذف'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteStudent(studentId);
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        SearchWidget(onSearch: _filterStudents),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
          child: GridView.count(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 9),
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            shrinkWrap: true,
            children: List.generate(
              _students.length,
              (index) {
                var student = _students[index];
                student['isTested'] ??= false;
                int counter = index + 1;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentProfile(
                          studentId: student['id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.008,
                        bottom: screenHeight * 0.008,
                        right: screenWidth * 0.035,
                        left: screenWidth * 0.012),
                    margin: EdgeInsets.only(top: screenHeight * 0.013),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton(
                          color: Colors.white,
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: '1',
                                child: Center(
                                  child: Text(
                                    'حساب الطالب',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: '2',
                                child: Center(
                                  child: Text(
                                    'حذف',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            if (value == '1') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => StudentProfile(
                                          studentId: student['id'],
                                        )),
                              );
                            } else if (value == '2') {
                              _showDeleteConfirmationDialog(
                                  context, student['id']);
                            }
                          },
                          icon: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: Colors.grey[500],
                            size: screenHeight * 0.02,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.001),
                        Container(
                          width: screenHeight * 0.1,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.012,
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.021),
                          decoration: BoxDecoration(
                            color: student['isTested']
                                ? Colors.green[100]
                                : Colors.red[100],
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.016),
                          ),
                          child: Center(
                            child: Text(
                              student['isTested']
                                  ? "تم الاختبار"
                                  : "لم يتم الاختبار",
                              style: TextStyle(
                                  color: student['isTested']
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
                              SizedBox(height: screenHeight * 0.007),
                              Text(
                                student['id'],
                                style: TextStyle(
                                  fontSize: screenHeight * 0.014,
                                  color: const Color(0xFF999999),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                student['fullName'],
                                style: TextStyle(
                                  fontSize: screenHeight * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              FutureBuilder(
                                future:
                                    (student['teacher'] as DocumentReference)
                                        .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) return Container();

                                  var teacher =
                                      (snapshot.data as DocumentSnapshot).data()
                                          as Map<String, dynamic>;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        teacher['name'],
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.013,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        'المسؤول: ',
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.013,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.046),
                        Text(
                          '$counter', // Display the counter value
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.016,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.022,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
