// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/Admin/teacher_profile.dart';
import 'package:yaqidh_first/core/db.dart';

class TeacherNameListWidget extends StatefulWidget {
  const TeacherNameListWidget({Key? key}) : super(key: key);
  @override
  State<TeacherNameListWidget> createState() => _TeacherNameListWidgetState();
}

class _TeacherNameListWidgetState extends State<TeacherNameListWidget> {
  List<DocumentSnapshot<Object?>> _teachers = [];

  @override
  void initState() {
    YDB.getRecentlyCreatedTeachers().then((result) {
      setState(() {
        _teachers = result;
      });
    });
    super.initState();
  }

  void navigateToTeacherProfile(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TeacherProfile(
                  teacherId: _teachers[index].id,
                )));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
      child: GridView.count(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 9.7),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        shrinkWrap: true,
        children: List.generate(
          _teachers.length > 3 ? 3 : _teachers.length,
          (index) => InkWell(
            onTap: () {
              navigateToTeacherProfile(index);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.010,
                  horizontal: screenWidth * 0.015),
              margin: EdgeInsets.only(top: screenHeight * 0.013),
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
                        SizedBox(height: screenHeight * 0.008),
                        Text(
                          _teachers[index].id,
                          style: TextStyle(
                            fontSize: screenHeight * 0.014,
                            color: Color(0xFF999999),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          _teachers[index]['name'],
                          style: TextStyle(
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    FontAwesomeIcons.solidCircle,
                    color: Color(0xFF7FC7D9),
                    size: 10,
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
