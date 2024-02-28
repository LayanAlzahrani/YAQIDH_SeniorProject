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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * 0.065),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Text(
                    textFieldName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: screenSize.height * 0.008),
        Center(
          child: Container(
            height: screenSize.height * 0.04,
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
            decoration: BoxDecoration(
              color: Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(13.0),
            ),
            child: TextField(
              controller: textController,
              obscureText: obscureText,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFECECEC),
                        width: screenSize.width * 0.01),
                    borderRadius: BorderRadius.circular(13)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF7FC7D9),
                        width: screenSize.width * 0.01),
                    borderRadius: BorderRadius.circular(13)),
                prefixIcon: icon,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.024,
                    vertical: screenSize.height * 0.01),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
