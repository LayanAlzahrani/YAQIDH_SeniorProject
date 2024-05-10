// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/admin_profile.dart';
import 'package:yaqidh_first/Screens/Admin/homepage.dart';
import 'package:yaqidh_first/Screens/Admin/login.dart';
import 'package:yaqidh_first/Widgets/customBottomNavigationBar.dart';
import 'package:yaqidh_first/Widgets/myaccWidget.dart';
import 'package:yaqidh_first/Widgets/settingsWidget.dart';
import 'package:yaqidh_first/firebase_options.dart';

import 'package:yaqidh_first/core/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Tajawal', useMaterial3: true),
      home: MyAccount(),
    );
  }
}

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  // int _selectedIndex = 1;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  FirestoreOperationsProxy proxy = FirestoreOperationsProxy();

  Map<String, dynamic>? _admin;
  @override
  void initState() {
    super.initState();
    proxy.getAdmin().then((result) {
      setState(() {
        _admin = result;
      });
      print("Admin data: $_admin");
    });
  }

  @override
  Widget build(BuildContext context) {
    var admin = _admin;

    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        //elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'حسابي',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF365486),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
        color: const Color(0xFFF8F8F8),
        child: Center(
          child: Column(
            children: [
              if (admin != null) ...[
                MyAccWidget(name: admin['name'], id: admin['givenId']),
                SettingsWidget(
                  name: 'الإعدادات',
                  ontap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminProfile()),
                    );
                  },
                ),
                SettingsWidget(
                  name: 'تسجيل الخروج',
                  ontap: () {
                    signUserOut(context);
                  },
                ),
                // SettingsWidget(
                //   name: 'زر مؤقت عشان اروح للمعلم',
                //   ontap: () {
                //     // Navigator.of(context).push(
                //     //   MaterialPageRoute(
                //     //       builder: (context) => HomePageTeacher()),
                //     // );
                //   },
                // ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          }
        },
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
