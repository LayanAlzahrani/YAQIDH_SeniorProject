// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/Screens/Admin/myaccount.dart';
import 'package:yaqidh_first/Widgets/profile_info.dart';
import 'package:yaqidh_first/firebase_options.dart';

void main() async {
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
      home: const AdminProfile(),
    );
  }
}

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final double coverHeight = 85;
  final double profileHeight = 95;

  final currentUser = FirebaseAuth.instance.currentUser;

  final userCollection = FirebaseFirestore.instance.collection('users');

  //function to edit fields
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Edit $field",
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: TextStyle(color: Colors.grey)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('cancel')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: Text('save'))
        ],
      ),
    );
    // Update in firestore
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser?.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyAccount()),
            );
          },
        ),
        backgroundColor: Color(0xFF365486),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return Container(
              color: Color(0xFFF8F8F8),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildTop(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...[
                          InkWell(
                            onTap: () => editField('name'),
                            child: Text(
                              userData['name'],
                              style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          ProfileInfo(
                            sectionName: 'رقم التعريف',
                            info: userData['givenId'],
                            Align: MainAxisAlignment.end,
                          ),
                          ProfileInfo(
                            sectionName: 'البريد الإلكتروني',
                            info: userData['email'],
                            icon: IconButton(
                              icon: Icon(
                                Icons.settings,
                                size: screenHeight * 0.021,
                                color: Color.fromARGB(255, 179, 178, 178),
                              ),
                              onPressed: () => editField('email'),
                            ),
                            Align: MainAxisAlignment.spaceBetween,
                          ),
                          ProfileInfo(
                            sectionName: 'رقم الهاتف',
                            info: userData['phone'],
                            icon: IconButton(
                              icon: Icon(
                                Icons.settings,
                                size: screenHeight * 0.021,
                                color: Color.fromARGB(255, 179, 178, 178),
                              ),
                              onPressed: () => editField('phone'),
                            ),
                            Align: MainAxisAlignment.spaceBetween,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print('Error${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2 + 18;
    final top = coverHeight - profileHeight / 2 - 10;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom), child: buildCoverImage()),
        Positioned(top: top, child: buildPFP())
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Color(0xFF365486), // Set the color here
        width: double.infinity,
        height: coverHeight - 10,
      );

  Widget buildPFP() => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFFF8F8F8), // Set border color
            width: profileHeight / 19, // Set border width
          ),
        ),
        child: CircleAvatar(
          radius: profileHeight / 2,
          // backgroundColor: Colors.grey.shade800,
          backgroundImage: NetworkImage(
            "https://drive.google.com/uc?export=view&id=1sE88XrMfk_xWqdSES3k3NVeEnpU70n1t",
          ),
        ),
      );
}
