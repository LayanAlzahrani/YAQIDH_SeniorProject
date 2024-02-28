// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yaqidh_first/Screens/homepage.dart';
import 'package:yaqidh_first/Widgets/buttonWidget.dart';
import 'package:yaqidh_first/Widgets/login_textfield.dart';
import 'package:yaqidh_first/firebase_options.dart';
import 'package:yaqidh_first/user_auth/firebase_auth_services.dart';

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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthPage _auth = AuthPage();

  //To secure the password
  bool _obscureText = true;
  //Text editing Controlllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _emailError = false;
  bool _passwordError = false;

  //For errors which i didn't use, not yet anyways
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              'https://drive.google.com/uc?export=view&id=1RYgADNjK6VMqOAIxB9pjMbfcKCsxZ-SU',
              //width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            LayoutBuilder(
              builder: (context, constraints) {
                var deviceType = getDeviceType(mediaQueryData);
                if (deviceType == DeviceType.tablet) {
                  return Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.001),
                    //width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035),
                          LoginFields(
                            obscureText: false,
                            textController: _emailController,
                            icon: Icon(
                              FontAwesomeIcons.solidEnvelope,
                              color: Colors.grey,
                              size: 16,
                            ),
                            textFieldName: 'البريد الالكتروني',
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.016),
                          LoginFields(
                            obscureText: _obscureText,
                            textController: _passwordController,
                            icon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? FontAwesomeIcons.solidEyeSlash
                                    : FontAwesomeIcons.solidEye,
                                color: Colors.grey,
                                size: 16,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            textFieldName: 'كلمة المرور',
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.009),
                          GestureDetector(
                            onTap: () {
                              // ddd
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.065),
                                  child: Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF365486),
                                      decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.032),
                          Center(
                            child: MyButton(
                              onTap: () {
                                _signIn();
                              },
                              buttonName: 'تسجيل',
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.0001),
                    //width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035),
                          LoginFields(
                            obscureText: false,
                            textController: _emailController,
                            icon: Icon(
                              FontAwesomeIcons.solidEnvelope,
                              color: Colors.grey,
                              size: 16,
                            ),
                            textFieldName: 'البريد الالكتروني',
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          LoginFields(
                            obscureText: _obscureText,
                            textController: _passwordController,
                            icon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? FontAwesomeIcons.solidEyeSlash
                                    : FontAwesomeIcons.solidEye,
                                color: Colors.grey,
                                size: 16,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            textFieldName: 'كلمة المرور',
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.009),
                          GestureDetector(
                            onTap: () {
                              // ddd
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.065),
                                  child: Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF365486),
                                      decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.032),
                          Center(
                            child: MyButton(
                              onTap: () {
                                _signIn();
                              },
                              buttonName: 'تسجيل',
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    //Loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF7FC7D9),
            ),
          );
        });

    setState(() {
      _emailError = _emailController.text.isEmpty;
      _passwordError = _passwordController.text.isEmpty;
    });

    if (!_emailError && !_passwordError) {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {}
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'فشل تسجيل الدخول',
                textAlign: TextAlign.right,
              ),
              content: Text(
                'الرجاء تعبئة البيانات',
                textAlign: TextAlign.right,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('حسنًا'),
                ),
              ],
            );
          });
    }
  }

  DeviceType getDeviceType(MediaQueryData mediaQueryData) {
    Orientation orientation = mediaQueryData.orientation;
    double width = 0;
    if (orientation == Orientation.landscape) {
      width = mediaQueryData.size.height;
    } else {
      width = mediaQueryData.size.width;
    }

    if (width >= 950) {
      return DeviceType.desktop;
    } else if (width >= 600) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }
}

enum DeviceType { mobile, tablet, desktop }
