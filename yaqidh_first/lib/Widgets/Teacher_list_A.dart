// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/teacher_profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeacherNamesForAdmin extends StatelessWidget {
  final bool isTested = false;

  const TeacherNamesForAdmin({Key? key}) : super(key: key);

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
                      builder: (context) => TeacherProfile()),
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
                    PopupMenuButton(
                      color: Colors.white,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: '1',
                            child: Center(
                              child: Text(
                                'حساب المعلم',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem(
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
                                builder: (context) => TeacherProfile()),
                          );
                        } else if (value == '2') {
                          // Handle action for item 2
                        } 
                      },
                      icon: Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: Colors.grey[500],
                        size: screenHeight * 0.02,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            "رقم المعلم",
                            style: TextStyle(
                              fontSize: screenHeight * 0.012,
                              color: Color(0xFF999999),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "إسم المعلم",
                            style: TextStyle(
                              fontSize: screenHeight * 0.013,
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