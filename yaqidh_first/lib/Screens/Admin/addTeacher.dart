import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/Teacher_listt.dart';
import 'package:yaqidh_first/core/db.dart';

import '../../core/fire_auth.dart';

void main() {
  runApp(const AddTeacherScreen());
}

class AddTeacherScreen extends StatelessWidget {
  const AddTeacherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return MaterialApp(
      title: 'إنشاء حساب معلم ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Tajawal',
          useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TeacherListAdmin()),
            ),
            child: const SizedBox(
              height: double.infinity, // Adjust the height as needed
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text(
                    'تراجع',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          title: const Text(
            'إنشاء حساب معلم ',
            style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF365486),
        ),
        body: Container(
          color: const Color(0xFFF8F8F8),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.045),
                  child: Text(
                    ': الرجاء تعبئة البيانات التالية ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.017,
                    ),
                  ),
                ),
                const AccountActivationForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountActivationForm extends StatefulWidget {
  const AccountActivationForm({Key? key}) : super(key: key);

  @override
  _AccountActivationFormState createState() => _AccountActivationFormState();
}

class _AccountActivationFormState extends State<AccountActivationForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'إسم المعلم',
                style: TextStyle(
                  fontSize: screenHeight * 0.015, // Custom font size
                  color: const Color(0xFF888888),
                  fontFamily: 'Tajawal', // Custom font family
                ),
              ), // Information above name text field
              _buildCurvedTextField(
                  nameController), // Building text field for name
            ],
          ),
        ),

        SizedBox(
          height: screenHeight * 0.015,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ' البريد الالكتروني للمعلم ',
                style: TextStyle(
                  fontSize: screenHeight * 0.015,
                  color: const Color(0xFF888888),
                  fontFamily: 'Tajawal',
                ),
              ),
              _buildCurvedTextField(emailController),
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'رقم هاتف المعلم ',
                style: TextStyle(
                  fontSize: screenHeight * 0.015,
                  color: const Color(0xFF888888),
                  fontFamily: 'Tajawal', // Custom font family
                ),
              ), // Information above phone number text field
              _buildCurvedTextField(
                  phoneController), // Building text field for phone number
            ],
          ),
        ),
        SizedBox(
            height: screenHeight * 0.039), // Added SizedBox for equal space
        SizedBox(
          width: 290,
          height: 60,
          child: MyButton3(
              buttonName: 'تفعيل حساب المعلم',
              onTap: () async {
                var teacherID = "1${YDB.generateRandomNumber(7)}";
                // Perform action to activate the account here
                // For now, let's just print the entered data
                print('Teacher Name: ${nameController.text}');
                print('Email: ${emailController.text}');
                print('Phone Number: ${phoneController.text}');

                // TODO: teacher must be selected
                // Add user to Firestore database

                await FireAuth.register(emailController.text, "123456", context)
                    .then(
                  (value) {
                    try {
                      DocumentReference documentReference = FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(value!.uid);
                      documentReference.set({
                        "TId": teacherID,
                        'userType': 'teacher',
                        'name': nameController.text,
                        'email': emailController.text,
                        'phone': phoneController.text,
                        'password': '123456',
                        //YDB.generateRandomPassword(),
                        'createdAt': FieldValue.serverTimestamp(),
                      }).then((_) async {
                        nameController.clear();
                        emailController.clear();
                        phoneController.clear();
                        _showConfirmationDialog('تمت إضافة المعلم بنجاح.');
                      }).catchError((error) {
                        print("Failed to add user: $error");
                      });
                    } catch (e) {
                      debugPrint(e.toString());
                    } finally {
                      setState(() {});
                    }

                    // FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(teacherID)
                    //     .set({
                    //   'userType': 'teacher',
                    //   'name': nameController.text,
                    //   'email': emailController.text,
                    //   'phone': phoneController.text,
                    //   'password': '123456',
                    //   //YDB.generateRandomPassword(),
                    //   'createdAt': FieldValue.serverTimestamp(),
                    // }).then((_) async {
                    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    //     email: emailController.text,
                    //     password: '123456',
                    //   );
                    //   nameController.clear();
                    //   emailController.clear();
                    //   phoneController.clear();
                    //   _showConfirmationDialog('تمت إضافة المعلم بنجاح.');
                    // }).catchError((error) {
                    //   print("Failed to add user: $error");
                    // });
                  },
                );
              }),
        ),
      ],
    );
  }

  // Function to build curved text field
  Widget _buildCurvedTextField(TextEditingController controller) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        height: screenHeight * 0.05,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.001),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: TextField(
          style: TextStyle(fontSize: screenHeight * 0.018),
          controller: controller,
          textAlign: TextAlign.right,
          textAlignVertical: TextAlignVertical.top,
          cursorHeight: screenHeight * 0.025,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color(0xFFECECEC), width: screenWidth * 0.003),
                borderRadius: BorderRadius.circular(13)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color(0xFF7FC7D9), width: screenWidth * 0.003),
                borderRadius: BorderRadius.circular(13)),
          ),
        ),
      ),
    );
  }
  // return SizedBox(
  //   height: 40, // Set the height of the TextField
  //   width: screenWidth * 1, // Set the width of the TextField
  //   child: Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white, // Set the container color to white
  //       borderRadius: BorderRadius.circular(10), // Curved corners
  //       border: Border.all(
  //           color: Color.fromARGB(255, 201, 201, 201)), // Gray border
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
  //       child: TextField(
  //         textAlignVertical: TextAlignVertical.top,
  //         controller: controller,
  //         textAlign: TextAlign.right, // Right-align text
  //         textDirection:
  //             TextDirection.rtl, // Set text direction to right-to-left
  //         decoration: const InputDecoration(
  //           border: InputBorder.none, // No border inside the container
  //           fillColor: Colors.white, // White fill color
  //           filled: true,
  //         ),
  //       ),

  // void _selectTeacher() async {
  //   var teacher = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const SelectTeacher()),
  //   );
  //   setState(() {
  //     _selectedTeacher = teacher;
  //   });
  // }

  void _showConfirmationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تمت الإضافة بنجاح'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('حسنا'),
            ),
          ],
        );
      },
    );
  }
}

class MyButton3 extends StatelessWidget {
  final Function()? onTap;
  final String buttonName;

  const MyButton3({super.key, required this.onTap, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.012, vertical: screenHeight * 0.009),
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.018, vertical: screenHeight * 0.011),
        decoration: BoxDecoration(
            color: const Color(0xFF7FC7D9),
            borderRadius: BorderRadius.circular(13)),
        child: Center(child: LayoutBuilder(
          builder: (context, constraints) {
            return Text(
              buttonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.015,
                  fontWeight: FontWeight.bold),
            );
          },
        )),
      ),
    );
  }
}
