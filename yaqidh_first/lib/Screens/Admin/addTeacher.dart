import 'package:flutter/material.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إنشاء حساب معلم ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'إنشاء حساب معلم ',
            style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF365486),
          leading: Container(
            height: double.infinity, // Adjust the height as needed
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  'تراجع',
                  style: TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 40), // Added SizedBox for equal space
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
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
  @override
  _AccountActivationFormState createState() => _AccountActivationFormState();
}

class _AccountActivationFormState extends State<AccountActivationForm> {
  // Initializing TextEditingController for each text field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
@override
Widget build(BuildContext context) {
  // Building the UI for account activation form
  return Column(
    children: [
      SizedBox(height: 20), // Added SizedBox for equal space
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'إسم المعلم',
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
      SizedBox(height: 20), // Added SizedBox for equal space
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ' البريد الالكتروني',
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
      SizedBox(height: 25), // Added SizedBox for equal space
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'رقم الهاتف    ',
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
      SizedBox(height: 40), // Added SizedBox for equal space
Container(
  width: 290, // Set the desired width for the ElevatedButton
  height: 60, // Set the desired height for the ElevatedButton
  child: ElevatedButton(
    onPressed: () {
      // Perform action to activate the account here
      // For now, let's just print the entered data
      print('Student Name: ${nameController.text}');
      print('Email: ${emailController.text}');
      print('Phone Number: ${phoneController.text}');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor:  Color.fromRGBO(127, 199, 217, 1.0), // Background color
      foregroundColor: Color.fromARGB(255, 255, 255, 255), // Text color
      textStyle: TextStyle(
        fontSize: 19,
        fontWeight:FontWeight.bold, // Custom font size
        fontFamily: 'Tajawal', // Custom font family
      ),
    ),
    child: Text(
      'تفعيل حساب المعلم',
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
          decoration: InputDecoration(
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
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}


