// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Teacher/game.dart';
import 'package:yaqidh_first/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Tajawal', useMaterial3: true),
      home: StudentSelection(),
    );
  }
}

class StudentSelection extends StatefulWidget {
  const StudentSelection({Key? key}) : super(key: key);

  @override
  State<StudentSelection> createState() => _StudentSelectionState();
}

class _StudentSelectionState extends State<StudentSelection> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Game()),
            );
          },
          child: Container(
            padding: EdgeInsets.only(left: screenWidth * 0.034),
            alignment: Alignment.center,
            child: Text(
              'تراجع',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        ),
        title: const Text(
          'إختيار الطلاب',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.034),
              child: Text(
                'إنشاء',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.018,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF365486),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF8F8F8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.only(
                  right: screenHeight * 0.022, top: screenHeight * 0.022),
              child: Text(
                "اختر الطلاب الذين ترغب في اختبارهم:",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: screenHeight * 0.017,
                    fontWeight: FontWeight.bold),
              ),
            ),
            buildList(context),
          ]),
        ),
      ),
    );
  }
}

Widget buildList(BuildContext context) {
  //String name;
  double screenHeight = MediaQuery.sizeOf(context).height;
  double screenWidth = MediaQuery.sizeOf(context).width;
  //bool isSelected = false;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
    child: GridView.count(
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 9.7),
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 1,
      shrinkWrap: true,
      children: List.generate(
        4,
        (index) {
          int counter = index + 1;
          return InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.012,
                  horizontal: screenWidth * 0.035),
              margin: EdgeInsets.only(top: screenHeight * 0.013),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: screenWidth * 0.01),
                  Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "رقم الطالب",
                          style: TextStyle(
                            fontSize: screenHeight * 0.012,
                            color: Color(0xFF999999),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          "إسم الطالب",
                          style: TextStyle(
                            fontSize: screenHeight * 0.013,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.046),
                  Text(
                    '$counter', // Display the counter value
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.016,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.022,
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
