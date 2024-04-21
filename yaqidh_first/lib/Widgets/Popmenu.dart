import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          // 1st menu option with text
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: Center(
              child: const Text(
                'حساب الطالب',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // 2nd menu option with text
          PopupMenuItem(
            child: Center(
              child: Text(
                'إضافة إلى معلم',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // 3rd menu option with text
          PopupMenuItem(
            child: Center(
              child: Text(
                'حذف',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ];
      },
      color: Colors.white, // Set background color of the popup menu
      elevation: 0, // Remove the elevation (shadow) of the popup menu
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set border radius as desired
        side: BorderSide(color: Colors.white), 
      ),
    );
  }
}
