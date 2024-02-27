// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  // final String info;
  // final String sectionName;

  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 8,
      //physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 1,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            padding: EdgeInsets.only(top: 6, bottom: 4, right: 10, left: 10),
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              /*Colors.white,*/
              //borderRadius: BorderRadius.circular(15),
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "اسم الحقل",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF999999)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "المعلومات",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
