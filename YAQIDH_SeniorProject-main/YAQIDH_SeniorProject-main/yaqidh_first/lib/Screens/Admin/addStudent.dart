import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

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
          leading: const SizedBox(
            height: double.infinity, // Adjust the height as needed
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  'تراجع',
                  style: TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 40), // Added SizedBox for equal space
            Padding(
              padding: EdgeInsets.only(right: 16.0, left: 16.0),
              child: Text(
                ': الرجاء تعبئة البيانات التالية ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Tajawal'),
              ),
            ),
            SizedBox(height: 20), // Added SizedBox for equal space
            AccountActivationForm(),
          ],
        ),
      ),
    );
  }
}



// Importing material.dart for Flutter widgets

class AccountActivationForm extends StatefulWidget {
  const AccountActivationForm({super.key});

  @override
  _AccountActivationFormState createState() => _AccountActivationFormState();
}

class _AccountActivationFormState extends State<AccountActivationForm> {
  // Initializing TextEditingController for each text field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
@override
Widget build(BuildContext context) {
  // Building the UI for account activation form
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
            _buildCurvedTextField(nameController), // Building text field for name
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
              'تاريخ الميلاد',
              style: TextStyle(
                fontSize: 16, // Custom font size
                color: Color(0xFF888888),
                fontFamily: 'Tajawal', // Custom font family
              ),
            ), // Information above date of birth text field
            _buildCurvedTextField(dobController), // Building text field for date of birth
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
            _buildCurvedTextField(emailController), // Building text field for email
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
            _buildCurvedTextField(phoneController), // Building text field for phone number
          ],
        ),
      ),
      const SizedBox(height: 40), // Added SizedBox for equal space
SizedBox(
  width: 290, // Set the desired width for the ElevatedButton
  height: 60, // Set the desired height for the ElevatedButton
  child: ElevatedButton(
    onPressed: () {
      // Perform action to activate the account here
      // For now, let's just print the entered data
      print('Student Name: ${nameController.text}');
      print('Date of Birth: ${dobController.text}');
      print('Email: ${emailController.text}');
      print('Phone Number: ${phoneController.text}');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor:  const Color.fromRGBO(127, 199, 217, 1.0), // Background color
      foregroundColor: const Color.fromARGB(255, 255, 255, 255), // Text color
      textStyle: const TextStyle(
        fontSize: 19,
        fontWeight:FontWeight.bold, // Custom font size
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

  // Dispose method to dispose of text controllers when the widget is removed from the tree
  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}


