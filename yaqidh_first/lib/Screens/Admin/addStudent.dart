import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaqidh_first/Screens/Admin/select_teacher.dart';
import 'package:yaqidh_first/core/db.dart';
import 'package:intl/intl.dart';

void main() async {
  // Initialize Firebase before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AddStudentScreen());
}

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'إنشاء حساب طالب ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Tajawal',
          useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'إنشاء حساب طالب ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF365486),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
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
        ),
        body: Container(
          color: Color(0xFFF8F8F8),
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
                AccountActivationForm(),
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

  DateTime _currentDob = DateTime.now();
  Map<String, dynamic>? _selectedTeacher;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'إسم الطالب',
                style: TextStyle(
                  fontSize: screenHeight * 0.015, // Custom font size
                  color: Color(0xFF888888),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'تاريخ الميلاد',
                    style: TextStyle(
                      fontSize: screenHeight * 0.015, // Custom font size
                      color: Color(0xFF888888),
                      fontFamily: 'Tajawal', // Custom font family
                    ),
                  )
                ],
              ), // Information above date of birth text field
              GestureDetector(
                onTap: _showDatePicker,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13), // Curved corners
                    border: Border.all(color: Color(0xFFECECEC)), // Gray border
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.008),
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(_currentDob),
                    ),
                  ),
                ),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "المسؤول عن التشخيص",
                    style: TextStyle(
                      fontSize: screenHeight * 0.015, // Custom font size
                      color: const Color(0xFF888888),
                      fontFamily: 'Tajawal', // Custom font family
                    ),
                  )
                ],
              ), // Information above date of birth text field
              GestureDetector(
                onTap: _selectTeacher,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // Curved corners
                    border: Border.all(color: Color(0xFFECECEC)), // Gray border
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.008),
                    child: Text(_selectedTeacher?['name'] ?? 'اختر مسؤول'),
                  ),
                ),
              ),
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
                ' البريد الالكتروني لـ ولي أمر الطالب ',
                style: TextStyle(
                  fontSize: screenHeight * 0.015, // Custom font size
                  color: Color(0xFF888888),
                  fontFamily: 'Tajawal', // Custom font family
                ),
              ), // Information above email text field
              _buildCurvedTextField(
                  emailController), // Building text field for email
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
                'رقم هاتف ولي أمر الطالب ',
                style: TextStyle(
                  fontSize: screenHeight * 0.015, // Custom font size
                  color: Color(0xFF888888),
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
          width: 290, // Set the desired width for the ElevatedButton
          height: 60, // Set the desired height for the ElevatedButton
          child: MyButton3(
              onTap: () {
                var studentId = "2${YDB.generateRandomNumber(6)}";
                // Perform action to activate the account here
                // For now, let's just print the entered data
                print('Student Name: ${nameController.text}');
                print('Date of Birth: $_currentDob');
                print('Email: ${emailController.text}');
                print('Phone Number: ${phoneController.text}');

                // TODO: teacher must be selected
                // Add user to Firestore database
                FirebaseFirestore.instance
                    .collection('students')
                    .doc(studentId)
                    .set({
                  'fullName': nameController.text,
                  'age': _currentDob,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  "isTested": false,
                  "teacher": FirebaseFirestore.instance
                      .collection('users')
                      .doc(_selectedTeacher?['id'])
                }).then((_) {
                  // Clear text fields after adding user
                  nameController.clear();
                  emailController.clear();
                  phoneController.clear();
                  _selectedTeacher = null;
                  // TODO: Add A message
                }).catchError((error) {
                  // Handle error if adding user fails
                  print("Failed to add user: $error");
                });
              },
              buttonName: 'تفعيل حساب الطالب'),
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
          color: Color.fromARGB(255, 255, 255, 255),
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
                    color: Color(0xFFECECEC), width: screenWidth * 0.003),
                borderRadius: BorderRadius.circular(13)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFF7FC7D9), width: screenWidth * 0.003),
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

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _currentDob,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value != null) {
        setState(() {
          _currentDob = value;
        });
      }
    });
  }

  void _selectTeacher() async {
    var teacher = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectTeacher()),
    );
    setState(() {
      _selectedTeacher = teacher;
    });
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
            color: Color(0xFF7FC7D9), borderRadius: BorderRadius.circular(13)),
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
