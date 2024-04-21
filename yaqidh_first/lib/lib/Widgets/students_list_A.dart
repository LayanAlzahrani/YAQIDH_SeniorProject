// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/student_profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllStudentNamesForAdmin extends StatelessWidget {
  final bool isTested = false;

  const AllStudentNamesForAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
      child: ListView( // Wrap with ListView
        children: [
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            shrinkWrap: true,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 9.7),
            children: List.generate(
              12,
              (index) {
                int counter = index + 1;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentProfile(),
                      ),
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
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: Colors.grey[500],
                            size: screenHeight * 0.02,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Container(
                          width: screenHeight * 0.1,
                          margin: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.013),
                          decoration: BoxDecoration(
                            color: isTested
                                ? Colors.red[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(
                                screenHeight * 0.016),
                          ),
                          child: Center(
                            child: Text(
                              isTested ? "لم يتم الاختبار" : "تم الاختبار",
                              style: TextStyle(
                                  color: isTested
                                      ? Colors.red[600]
                                      : Colors.green[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight * 0.013),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                "رقم الطالب",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.012,
                                  color: Color(0xFF999999),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                "إسم الطالب",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.013,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                               Text(
                                "المعلم",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.013,
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
        ],
      ),
    );
  }
}

