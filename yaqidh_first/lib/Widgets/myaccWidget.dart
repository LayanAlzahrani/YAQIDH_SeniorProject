import 'package:flutter/material.dart';

class MyAccWidget extends StatelessWidget {
  final String name;
  final String id;

  const MyAccWidget({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.022),
      child: GridView.count(
        childAspectRatio: screenWidth / screenHeight * 9,
        crossAxisCount: 1,
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.006,
            ),
            margin: EdgeInsets.only(
              top: screenHeight * 0.02,
              left: screenWidth * 0.015,
              right: screenWidth * 0.0001,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.015),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        id,
                        style: TextStyle(
                          fontSize: screenHeight * 0.014,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                CircleAvatar(
                  radius: screenHeight * 0.034,
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
