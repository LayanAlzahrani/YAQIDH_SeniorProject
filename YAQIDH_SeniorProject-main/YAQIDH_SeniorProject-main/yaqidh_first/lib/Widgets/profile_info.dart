// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String info;
  final String sectionName;

  const ProfileInfo({
    super.key,
    required this.sectionName,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      padding: EdgeInsets.only(
          top: screenHeight * 0.007,
          bottom: screenHeight * 0.001,
          right: screenWidth * 0.007,
          left: screenWidth * 0.007),
      margin: EdgeInsets.only(
          top: screenHeight * 0.012,
          left: screenWidth * 0.012,
          right: screenWidth * 0.012),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        border: Border(
            bottom: BorderSide(
                width: screenWidth * 0.0016, color: Color(0xFFD9D9D9))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                    fontSize: screenHeight * 0.013,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF999999)),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.003),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                info,
                style: TextStyle(
                    fontSize: screenHeight * 0.015,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
