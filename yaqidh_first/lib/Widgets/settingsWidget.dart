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
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
      child: GridView.count(
        childAspectRatio: 14,
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
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.005,
                  horizontal: screenWidth * 0.012),
              margin: EdgeInsets.only(
                  top: screenHeight * 0.006,
                  left: screenWidth * 0.019,
                  right: screenWidth * 0.019),
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                border: Border(
                    bottom: BorderSide(
                        width: screenWidth * 0.0016, color: Color(0xFFD9D9D9))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Color(0xFFB3B3B3),
                    size: screenHeight * 0.017,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.008),
                          child: Text(
                            "الإعدادات",
                            style: TextStyle(
                                fontSize: screenHeight * 0.014,
                                fontWeight: FontWeight.normal),
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
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.005,
                  horizontal: screenWidth * 0.012),
              margin: EdgeInsets.only(
                  top: screenHeight * 0.006,
                  left: screenWidth * 0.019,
                  right: screenWidth * 0.019),
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                /*Colors.white,*/
                //borderRadius: BorderRadius.circular(15),
                border: Border(
                    bottom: BorderSide(
                        width: screenWidth * 0.0016, color: Color(0xFFD9D9D9))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Color(0xFFB3B3B3),
                    size: screenHeight * 0.017,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.008),
                          child: Text(
                            "تسجيل الخروج",
                            style: TextStyle(
                                fontSize: screenHeight * 0.014,
                                fontWeight: FontWeight.normal),
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
