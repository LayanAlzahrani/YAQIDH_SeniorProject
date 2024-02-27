// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/admin_profile.dart';
import 'package:yaqidh_first/Screens/login.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: GridView.count(
        childAspectRatio: 11,
        //physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        shrinkWrap: true,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AdminProfile()),
              );
            },
            child: Container(
              padding: EdgeInsets.only(top: 6, bottom: 4, right: 10, left: 10),
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                /*Colors.white,*/
                //borderRadius: BorderRadius.circular(15),
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Color(0xFFB3B3B3),
                    size: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "الإعدادات",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              signUserOut(context);
            },
            child: Container(
              padding: EdgeInsets.only(top: 6, bottom: 4, right: 10, left: 10),
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                /*Colors.white,*/
                //borderRadius: BorderRadius.circular(15),
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Color(0xFFB3B3B3),
                    size: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "تسجيل الخروج",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }
}
