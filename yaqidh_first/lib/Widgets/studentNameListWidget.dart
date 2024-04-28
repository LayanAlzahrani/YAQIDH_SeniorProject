// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/Admin/student_profile.dart';
import 'package:yaqidh_first/core/db.dart';

class NameListWidget extends StatefulWidget {
  const NameListWidget({Key? key});

  @override
  State<NameListWidget> createState() => _NameListWidgetState();
}

class _NameListWidgetState extends State<NameListWidget> {
  List<DocumentSnapshot<Object?>> _students = [];

  @override
  void initState() {
    YDB.getRecentlyCreatedStudents().then((result) {
      setState(() {
        _students = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
      child: GridView.count(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 9),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        shrinkWrap: true,
        children: List.generate(
          _students.length > 3 ? 3 : _students.length,
          (index) => InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StudentProfile()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.012,
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
                        SizedBox(height: screenHeight * 0.003),
                        Text(
                          _students[index].id,
                          style: TextStyle(
                            fontSize: screenHeight * 0.014,
                            color: Color(0xFF999999),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          _students[index]['fullName'],
                          style: TextStyle(
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        FutureBuilder(
                          future:
                              (_students[index]['teacher'] as DocumentReference)
                                  .get(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) return Container();
                            var teacher = (snapshot.data as DocumentSnapshot)
                                .data() as Map<String, dynamic>;
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
