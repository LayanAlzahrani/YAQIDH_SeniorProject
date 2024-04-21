// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonName;

  const MyButton({super.key, required this.onTap, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.012, vertical: screenHeight * 0.009),
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        decoration: BoxDecoration(
            color: Color(0xFF365486), borderRadius: BorderRadius.circular(13)),
        child: Center(child: LayoutBuilder(
          builder: (context, constraints) {
            return Text(
              buttonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.015,
                  fontWeight: FontWeight.bold),
            );
          },
        )),
      ),
    );
  }
}
