// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAccWidget extends StatelessWidget {
  const MyAccWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: GridView.count(
        childAspectRatio: 5.4,
        //physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.only(top: 18, bottom: 18, right: 15, left: 15),
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              /*Colors.white,*/
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end, // Align text to the right
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10), // Add padding above and below
                        child: Text(
                          "إسم المعلم",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 10), // Add padding above and below
                        child: Text(
                          "رقم المعلم",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF999999)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    "https://drive.google.com/uc?export=view&id=1sE88XrMfk_xWqdSES3k3NVeEnpU70n1t",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//https://drive.google.com/file/d/1sE88XrMfk_xWqdSES3k3NVeEnpU70n1t/view?usp=sharing