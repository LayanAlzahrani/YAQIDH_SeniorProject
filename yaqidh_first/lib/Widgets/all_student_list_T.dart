// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';

import '../Screens/Teacher/student_profile_T.dart';

class AllStudentNamesForTeacher extends StatelessWidget {
  final bool isTested = false;

  const AllStudentNamesForTeacher({Key? key}) : super(key: key);

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
          12,
          (index) {
            int counter = index + 1;
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StudentProfileForTeacher()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.012,
                    horizontal: screenWidth * 0.035),
                margin: EdgeInsets.only(top: screenHeight * 0.013),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     FontAwesomeIcons.ellipsisVertical,
                    //     color: Colors.grey[500],
                    //     size: screenHeight * 0.02,
                    //   ),
                    // ),
                    SizedBox(width: screenWidth * 0.01),
                    Container(
                      width: screenHeight * 0.1,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 0.012,
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.013),
                      decoration: BoxDecoration(
                        color: isTested ? Colors.green[100] : Colors.red[100],
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.016),
                      ),
                      child: Center(
                        child: Text(
                          isTested ? "تم الاختبار" : "لم يتم الاختبار",
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
                          SizedBox(height: screenHeight * 0.008),
                          Text(
                            "رقم الطالب",
                            style: TextStyle(
                              fontSize: screenHeight * 0.014,
                              color: Color(0xFF999999),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "إسم الطالب",
                            style: TextStyle(
                              fontSize: screenHeight * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
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
    );
  }
}
