import 'package:flutter/material.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قائمة الطلاب',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'قائمة الطلاب',
            style: TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF365486),
        ),
        body: StudentListPage(),
      ),
    );
  }
}

class StudentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 247, 243, 243),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(33.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '..ابحث',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 255, 253, 253),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: StudentList(),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Number of students
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: index.isEven ? Colors.white : Color.fromARGB(255, 249, 249, 249),
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // More options menu
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Text('حساب الطالب', style: TextStyle(fontFamily: 'Tajawal')),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text('إضافة الى معلم', style: TextStyle(fontFamily: 'Tajawal')),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text('حذف', style: TextStyle(fontFamily: 'Tajawal')),
                  ),
                ],
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 0:
                      // Handle "حساب الطالب" action
                      break;
                    case 1:
                      // Handle "إضافة الى معلم" action
                      break;
                    case 2:
                      // Handle "حذف" action
                      break;
                    default:
                  }
                },
              ),
              // Test status indicator
              Container(
                width: 110, // Adjusted width
                height: 40, // Adjusted height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: index.isEven ? Color.fromARGB(255, 176, 249, 178) : Color.fromARGB(255, 244, 182, 178),
                ),
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  index.isEven ? 'تم الاختبار' : 'لم يتم الإختبار',
                  style: TextStyle(
                    color: Colors.red, // Changed color to red
                    fontFamily: 'Tajawal',
                    fontSize: 16.0, // Adjusted font size
                  ),
                ),
              ),
              // Student information
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                                        Text(
                      'رقم الطالب',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Tajawal',
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      'اسم الطالب',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      'اسم المعلم المسؤول',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.right,
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}