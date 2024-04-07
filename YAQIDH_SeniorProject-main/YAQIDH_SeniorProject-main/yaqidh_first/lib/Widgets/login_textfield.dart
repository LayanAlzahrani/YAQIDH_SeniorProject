// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginFields extends StatelessWidget {
  final String textFieldName;
  final bool obscureText;
  final TextEditingController textController;
  final Widget? icon;

  const LoginFields(
      {super.key,
      required this.obscureText,
      required this.textController,
      required this.icon,
      required this.textFieldName});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.065),
              child: Text(
                textFieldName,
                style: TextStyle(
                    fontSize: screenHeight * 0.014,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.008),
        Center(
          child: Container(
            height: screenHeight * 0.04,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            decoration: BoxDecoration(
              color: Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(13.0),
            ),
            child: TextField(
              style: TextStyle(fontSize: screenHeight * 0.016),
              controller: textController,
              obscureText: obscureText,
              textAlign: TextAlign.right,
              cursorHeight: screenHeight * 0.018,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFECECEC), width: screenWidth * 0.01),
                    borderRadius: BorderRadius.circular(13)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF7FC7D9), width: screenWidth * 0.01),
                    borderRadius: BorderRadius.circular(13)),
                prefixIcon: icon,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.018),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
