// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:yaqidh_first/Screens/Admin/teacher_profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaqidh_first/core/db.dart';

class TeacherNamesForAdmin extends StatefulWidget {
  const TeacherNamesForAdmin({Key? key}) : super(key: key);

  @override
  State<TeacherNamesForAdmin> createState() => _TeacherNamesForAdminState();
}

class _TeacherNamesForAdminState extends State<TeacherNamesForAdmin> {
  List<Map<String, dynamic>> _teachers = [];
  List<Map<String, dynamic>> _allTeachers = [];

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  FirestoreOperationsProxy proxy = FirestoreOperationsProxy();

  Future<void> _fetchTeachers() async {
    try {
      final teachers = await proxy.getAllTeachers();
      setState(() {
        _teachers = teachers;
        _allTeachers = teachers;
      });
    } catch (error) {}
  }

  void _filterTeachers(String query) {
    if (query.isEmpty) {
      setState(() {
        _teachers = _allTeachers;
      });
    } else {
      setState(() {
        _teachers = _allTeachers.where((teacher) {
          final name = teacher['name'].toString().toLowerCase();
          final lowercaseQuery = query.toLowerCase();
          return name.contains(lowercaseQuery);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    void deleteTeacher(String teacherId) {
      proxy.deleteTeacher(teacherId).then((_) {
        setState(() {
          _teachers.removeWhere((student) => student['id'] == teacherId);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('تم حذف المعلم بنجاح'),
        ));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('خطأ في حذف المعلم: $error'),
        ));
      });
    }

    Future<void> showDeleteConfirmationDialog(
        BuildContext context, String studentId) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تأكيد الحذف'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('هل أنت متأكد أنك تريد حذف هذا المعلم؟'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('إلغاء'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('حذف'),
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteTeacher(studentId);
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        SearchWidget(onSearch: _filterTeachers),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.043),
          child: GridView.count(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 9.7),
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            shrinkWrap: true,
            children: List.generate(
              _teachers.length,
              (index) {
                var teacher = _teachers[index];
                int counter = index + 1;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TeacherProfile(
                          teacherId: teacher['id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.012,
                        bottom: screenHeight * 0.012,
                        right: screenWidth * 0.035,
                        left: screenWidth * 0.01),
                    margin: EdgeInsets.only(top: screenHeight * 0.013),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton(
                          color: Colors.white,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: '1',
                                child: Center(
                                  child: Text(
                                    'حساب المعلم',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: '2',
                                child: Center(
                                  child: Text(
                                    'حذف',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            if (value == '1') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TeacherProfile(
                                    teacherId: teacher['id'],
                                  ),
                                ),
                              );
                            } else if (value == '2') {
                              showDeleteConfirmationDialog(
                                  context, teacher['id']);
                            }
                          },
                          icon: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: Colors.grey[500],
                            size: screenHeight * 0.02,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: screenHeight * 0.008),
                              Text(
                                teacher['TId'],
                                style: TextStyle(
                                  fontSize: screenHeight * 0.014,
                                  color: Color(0xFF999999),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                teacher['name'],
                                style: TextStyle(
                                  fontSize: screenHeight * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.046),
                        Text(
                          '$counter', // Display the counter value
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.016,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.022,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchWidget({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.045, vertical: screenHeight * 0.01),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7FC7D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenHeight * 0.02),
              ),
            ),
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white,
              size: screenHeight * 0.02,
            ),
          ),
          SizedBox(width: screenWidth * 0.015),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * 0.02),
              ),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.00001),
              child: TextField(
                textAlign: TextAlign.right,
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: '...إبحث',
                  hintStyle: TextStyle(fontSize: screenHeight * 0.016),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
