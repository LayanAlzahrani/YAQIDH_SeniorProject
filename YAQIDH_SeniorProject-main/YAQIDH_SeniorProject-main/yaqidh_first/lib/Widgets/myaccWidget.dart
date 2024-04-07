// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAccWidget extends StatelessWidget {
  const MyAccWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.022),
      child: GridView.count(
        childAspectRatio: screenWidth / screenHeight * 9,
        //physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.006,
            ),
            margin: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.015,
                right: screenWidth * 0.0001),
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              /*Colors.white,*/
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.015),
                        child: Text(
                          "الإسم",
                          style: TextStyle(
                              fontSize: screenHeight * 0.015,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "رقم التعريف",
                        style: TextStyle(
                            fontSize: screenHeight * 0.014,
                            color: Color(0xFF999999)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                CircleAvatar(
                  radius: screenHeight * 0.034,
                  backgroundImage: NetworkImage(
                    "https://drive.google.com/uc?export=view&id=1sE88XrMfk_xWqdSES3k3NVeEnpU70n1t",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//https://drive.google.com/file/d/1sE88XrMfk_xWqdSES3k3NVeEnpU70n1t/view?usp=sharing