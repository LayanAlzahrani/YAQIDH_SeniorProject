// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final String imgUrl;
  final String fieldName;
  final Function()? ontap;
  const ListWidget(
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
        width: screenWidth * 0.44,
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.018, horizontal: screenWidth * 0.07),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.network(
              imgUrl,
              height: screenHeight * 0.074,
            ),
            SizedBox(height: screenHeight * 0.009),
            Text(
              fieldName,
              style: TextStyle(
                  fontSize: screenHeight * 0.016, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

/* imageUrl:
              "https://drive.google.com/uc?export=view&id=1VS5pzOzvOPWrLOR3JNkEp9MC9nplBHPW",
          title: "قائمة المعلمين",
          padding: EdgeInsets.symmetric(vertical: 20),
          margin: EdgeInsets.only(top: 26),
        ),
        _buildListItem(
          imageUrl:
              "https://drive.google.com/uc?export=view&id=1rfPcVZwuBt0pHf9vfvM4OkE4ZJvCqDVQ",
          title: "قائمة الطلاب",
          padding: EdgeInsets.symmetric(vertical: 20),
          margin: EdgeInsets.only(top: 0),*/

//id of teacher: 1VS5pzOzvOPWrLOR3JNkEp9MC9nplBHPW
//id of student: 1rfPcVZwuBt0pHf9vfvM4OkE4ZJvCqDVQ