import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens//Admin/homepage.dart';
import 'package:yaqidh_first/Screens/Admin/addStudent.dart';
import 'package:yaqidh_first/Widgets/student_list_Admin.dart';
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
      home: const StudentListAdmin(),
    );
  }
}

class StudentListAdmin extends StatefulWidget {
  const StudentListAdmin({Key? key}) : super(key: key);

  @override
  State<StudentListAdmin> createState() => _StudentListAdminState();
}

class _StudentListAdminState extends State<StudentListAdmin> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        title: const Text(
          'قائمة الطلاب',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF365486),
      ),
      body: Container(
        height: double.infinity,
        color: const Color(0xFFF8F8F8),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: screenHeight * 0.02),
            const StudentListForAdmin(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudentScreen()),
          );
        },
        tooltip: 'اضافة',
        backgroundColor: const Color(0xFF7FC7D9),
        foregroundColor: Colors.white,
        elevation: screenHeight * 0.002,
        child: Icon(
          FontAwesomeIcons.plus,
          size: screenHeight * 0.025,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
