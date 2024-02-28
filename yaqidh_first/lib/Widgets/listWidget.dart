// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
      child: GridView.count(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.001,
                    vertical: screenHeight * 0.001),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.network(
                      "https://drive.google.com/uc?export=view&id=1VS5pzOzvOPWrLOR3JNkEp9MC9nplBHPW",
                      height: screenHeight * 0.074,
                    ),
                    SizedBox(height: screenHeight * 0.009),
                    Text(
                      "قائمة المعلمين",
                      style: TextStyle(
                          fontSize: screenHeight * 0.016,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.001,
                    vertical: screenHeight * 0.001),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.network(
                      "https://drive.google.com/uc?export=view&id=1rfPcVZwuBt0pHf9vfvM4OkE4ZJvCqDVQ",
                      height: screenHeight * 0.074,
                    ),
                    SizedBox(height: screenHeight * 0.009),
                    Text(
                      "قائمة الطلاب",
                      style: TextStyle(
                          fontSize: screenHeight * 0.016,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ]),
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