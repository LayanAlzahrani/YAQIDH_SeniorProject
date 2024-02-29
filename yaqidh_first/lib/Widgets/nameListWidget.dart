// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NameListWidget extends StatelessWidget {
  const NameListWidget({Key? key});

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
          3,
          (index) => Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.012,
                horizontal: screenWidth * 0.015),
            margin: EdgeInsets.only(top: 15),
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
                        "إسم المعلم المسؤول",
                        style: TextStyle(
                          fontSize: screenHeight * 0.012,
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: TextDirection.rtl,
                      )
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
    );
  }
}
