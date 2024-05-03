import 'package:flutter/material.dart';
import 'package:yaqidh_first/core/db.dart';

class SelectTeacher extends StatefulWidget {
  const SelectTeacher({super.key});

  @override
  State<SelectTeacher> createState() => _SelectTeacherState();
}

class _SelectTeacherState extends State<SelectTeacher> {
  List<Map<String, dynamic>> _teachers = [];

  @override
  void initState() {
    _getTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اختيار معلم',
          style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF365486),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const SizedBox(
            height: double.infinity,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  'تراجع',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Tajawal', fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _teachers.length,
        itemBuilder: (context, index) {
          var teacher = _teachers[index];
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pop(context, teacher);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(teacher['name']),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  FirestoreOperationsProxy proxy = FirestoreOperationsProxy();

  void _getTeachers() {
    proxy.getAllTeachers().then((result) {
      setState(() {
        _teachers = result;
      });
    });
  }
}
