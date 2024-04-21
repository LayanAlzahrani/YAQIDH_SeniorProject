// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsWidget extends StatelessWidget {
  final String name;
  final Function()? ontap;

  const SettingsWidget({super.key, required this.name, required this.ontap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(
            top: screenHeight * 0.007,
            bottom: screenHeight * 0.005,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              FontAwesomeIcons.chevronLeft,
              color: Color(0xFFB3B3B3),
              size: screenHeight * 0.017,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.008),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: screenHeight * 0.014,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
