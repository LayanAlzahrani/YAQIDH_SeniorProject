import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
            FluentIcons.home_24_regular,
            size: screenHeight * 0.026,
          ),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.puzzle_piece_24_regular,
            size: screenHeight * 0.026,
          ),
          label: 'اللعبة',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.person_20_regular,
            size: screenHeight * 0.026,
          ),
          label: 'حسابي',
        ),
      ],
    );
  }
}
