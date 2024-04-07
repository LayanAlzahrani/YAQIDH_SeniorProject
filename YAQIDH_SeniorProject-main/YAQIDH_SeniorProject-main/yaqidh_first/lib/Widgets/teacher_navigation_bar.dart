import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeacherNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TeacherNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return BottomNavigationBar(
      selectedItemColor: const Color(0xFF365486),
      currentIndex: currentIndex,
      onTap: onTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
            size: screenHeight * 0.026,
          ),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.puzzlePiece,
            size: screenHeight * 0.026,
          ),
          label: 'اللعبة',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.solidUser,
            size: screenHeight * 0.026,
          ),
          label: 'حسابي',
        ),
      ],
    );
  }
}
