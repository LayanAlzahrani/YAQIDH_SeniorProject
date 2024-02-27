// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the item width based on the screen width
    double itemWidth = (screenWidth - 60) / 2;
    // Considering 20 padding on each side and 20 spacing between items

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: GridView.count(
        crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 20,
        crossAxisSpacing: 25,
        childAspectRatio: 2.1,
        children: [
          _buildListItem(
            imageUrl:
                "https://drive.google.com/uc?export=view&id=1VS5pzOzvOPWrLOR3JNkEp9MC9nplBHPW",
            title: "قائمة المعلمين",
            width: itemWidth,
          ),
          _buildListItem(
            imageUrl:
                "https://drive.google.com/uc?export=view&id=1rfPcVZwuBt0pHf9vfvM4OkE4ZJvCqDVQ",
            title: "قائمة الطلاب",
            width: itemWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required String imageUrl,
    required String title,
    required double width,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 95,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

//id of teacher: 1VS5pzOzvOPWrLOR3JNkEp9MC9nplBHPW
//id of student: 1rfPcVZwuBt0pHf9vfvM4OkE4ZJvCqDVQ