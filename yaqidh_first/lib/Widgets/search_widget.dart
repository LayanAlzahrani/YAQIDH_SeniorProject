import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.045, vertical: screenHeight * 0.01),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7FC7D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenHeight * 0.02),
              ),
            ),
            // ignore: deprecated_member_use
            child: Icon(
              FontAwesomeIcons.search,
              color: Colors.white,
              size: screenHeight * 0.02,
            ),
          ),
          SizedBox(width: screenWidth * 0.015),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * 0.02),
              ),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.00001),
              child: TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: '...إبحث',
                  hintStyle: TextStyle(fontSize: screenHeight * 0.016),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
