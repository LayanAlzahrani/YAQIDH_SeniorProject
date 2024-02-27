// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NameListWidget extends StatelessWidget {
  const NameListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: GridView.count(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 9.5),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        shrinkWrap: true,
        children: List.generate(
          3,
          (index) => Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.ellipsisVertical,
                    color: Colors.grey[500],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "رقم الطالب",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF999999),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        "إسم الطالب",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        "إسم المعلم المسؤول",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: TextDirection.rtl,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  FontAwesomeIcons.solidCircle,
                  color: Color(0xFF7FC7D9),
                  size: 10,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
