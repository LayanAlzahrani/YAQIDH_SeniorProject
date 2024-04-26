import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:yaqidh_first/Screens/Admin/select_teacher.dart';
import 'package:yaqidh_first/core/db.dart';

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
    return MaterialApp(
      title: 'إنشاء حساب طالب ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'إنشاء حساب طالب ',
            style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
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
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Tajawal',
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 40), // Added SizedBox for equal space
              Padding(
                padding: EdgeInsets.only(right: 16.0, left: 16.0),
                child: Text(
                  ': الرجاء تعبئة البيانات التالية ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
              SizedBox(height: 20), // Added SizedBox for equal space
              AccountActivationForm(),
            ],
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
    return Column(
      children: [
        const SizedBox(height: 20), // Added SizedBox for equal space
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'إسم الطالب',
                style: TextStyle(
                  fontSize: 16, // Custom font size
                  color: Color(0xFF888888),
                  fontFamily: 'Tajawal', // Custom font family
                ),
              ), // Information above name text field
              _buildCurvedTextField(
                  nameController), // Building text field for name
            ],
          ),
        ),
        const SizedBox(height: 20), // Added SizedBox for equal space
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'تاريخ الميلاد',
                    style: TextStyle(
                      fontSize: 16, // Custom font size
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
                    borderRadius: BorderRadius.circular(10), // Curved corners
                    border: Border.all(color: Colors.grey), // Gray border
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(_currentDob.toString()),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20), // Added SizedBox for equal space
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "المسؤول عن التشخيص",
                    style: TextStyle(
                      fontSize: 16, // Custom font size
                      color: Color(0xFF888888),
                      fontFamily: 'Tajawal', // Custom font family
                    ),
                  )
                ],
              ), // Information above date of birth text field
              GestureDetector(
                onTap: _selectTeacher,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Curved corners
                    border: Border.all(color: Colors.grey), // Gray border
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(_selectedTeacher?['name'] ?? 'اختر مسؤول'),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20), // Added SizedBox for equal space
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                ' البريد الالكتروني لـ ولي أمر الطالب ',
                style: TextStyle(
                  fontSize: 16, // Custom font size
                  color: Color(0xFF888888),
                  fontFamily: 'Tajawal', // Custom font family
                ),
              ), // Information above email text field
              _buildCurvedTextField(
                  emailController), // Building text field for email
            ],
          ),
        ),
        const SizedBox(height: 25), // Added SizedBox for equal space
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'رقم هاتف ولي أمر الطالب ',
                style: TextStyle(
                  fontSize: 16, // Custom font size
                  color: Color(0xFF888888),
                  fontFamily: 'Tajawal', // Custom font family
                ),
              ), // Information above phone number text field
              _buildCurvedTextField(
                  phoneController), // Building text field for phone number
            ],
          ),
        ),
        const SizedBox(height: 40), // Added SizedBox for equal space
        SizedBox(
          width: 290, // Set the desired width for the ElevatedButton
          height: 60, // Set the desired height for the ElevatedButton
          child: ElevatedButton(
            onPressed: () {
              var studentId = "2${YDB.generateRandomNumber(6)}";
              // Perform action to activate the account here
              // For now, let's just print the entered data
              print('Student Name: ${nameController.text}');
              print('Date of Birth: ${_currentDob}');
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
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromRGBO(127, 199, 217, 1.0), // Background color
              foregroundColor:
                  const Color.fromARGB(255, 255, 255, 255), // Text color
              textStyle: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold, // Custom font size
                fontFamily: 'Tajawal', // Custom font family
              ),
            ),
            child: const Text(
              'تفعيل حساب الطالب',
            ),
          ),
        ),
      ],
    );
  }

  // Function to build curved text field
  Widget _buildCurvedTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Curved corners
        border: Border.all(color: Colors.grey), // Gray border
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.right, // Right-align text
          decoration: const InputDecoration(
            border: InputBorder.none, // No border inside the container
            fillColor: Colors.white, // White fill color
            filled: true,
          ),
        ),
      ),
    );
  }

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
      MaterialPageRoute(builder: (context) => SelectTeacher()),
    );
    setState(() {
      _selectedTeacher = teacher;
    });
  }
}
