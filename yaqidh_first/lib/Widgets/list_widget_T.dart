// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentListContainer extends StatelessWidget {
  final String imgUrl;
  final String fieldName;
  final Function()? ontap;
  const StudentListContainer(
      {super.key,
      required this.imgUrl,
      required this.fieldName,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return InkWell(
      onTap: ontap,
      child: Container(
        width: screenWidth * 0.91,
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.018, horizontal: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Icon(
            //   FontAwesomeIcons.chevronLeft,
            //   color: Colors.grey[500],
            //   size: screenHeight * 0.02,
            // ),
            SizedBox(width: screenWidth * 0.34),
            Text(
              fieldName,
              style: TextStyle(
                  fontSize: screenHeight * 0.018, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: screenWidth * 0.02),
            Image.network(
              imgUrl,
              height: screenHeight * 0.075,
            ),
          ],
        ),
      ),
    );
  }
}
