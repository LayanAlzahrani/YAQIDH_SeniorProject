import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YDB {
  static CollectionReference _getCollection(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  static Future<Map<String, dynamic>> getDocumentDataById(
    String docId,
    String collectionName,
  ) async {
    var data = await _getCollection(collectionName).doc(docId).get();
    var map = data.data() as Map<String, dynamic>;
    return map;
  }

  static Future<List<Map<String, dynamic>>> getAllData(
    String collectionName,
  ) async {
    var snapshot = await _getCollection(collectionName).get();
    var data = snapshot.docs.map((e) {
      var docData = e.data() as Map<String, dynamic>;
      docData['id'] = e.id;
      return docData;
    }).toList();
    return data;
  }

  static Future<List<Map<String, dynamic>>> getAllTeachers() async {
    var data = await getAllData('users');
    return data
        .where((element) =>
            element['userType'].toString().toLowerCase() == 'teacher')
        .toList();
  }

  static Future<Map<String, dynamic>?> getAdmin() async {
    var data = await getAllData('users');

    var admin = data.firstWhere(
        (element) => element['userType'].toString().toLowerCase() == 'admin');
    return admin;
  }

  static Future<List<Map<String, dynamic>>> getAllStudents() async {
    return await getAllData('students');
  }

  static Future<List<DocumentSnapshot>> getRecentlyCreatedStudents() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs;
  }

  static Future<List<DocumentSnapshot>> getRecentlyCreatedTeachers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'teacher')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs;
  }

  static Future<List<Map<String, dynamic>>> getAllStudentsOfTeacher(
      String id) async {
    var data = await getAllData('students');
    return data
        .where((student) => (student['teacher'] as DocumentReference).id == id)
        .toList();
  }

  static String generateRandomNumber(int length) {
    Random random = Random();
    String number = '';

    for (int i = 0; i < length; i++) {
      number += random.nextInt(10).toString();
    }

    return number;
  }

  static String generateRandomPassword() {
    Random random = Random();
    String uppercaseLetter = String.fromCharCode(random.nextInt(26) + 65);
    String numbersAndLetters = '0123456789abcdefghijklmnopqrstuvwxyz';
    String randomLetters = List.generate(7,
            (_) => numbersAndLetters[random.nextInt(numbersAndLetters.length)])
        .join('');
    return uppercaseLetter + randomLetters;
  }

  static Future<void> deleteStudent(String studentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .delete();
    } catch (error) {
      print('Error deleting student: $error');
    }
  }

  static Future<void> deleteTeacher(String teacherId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(teacherId)
          .delete();
    } catch (error) {
      print('Error deleting student: $error');
    }
  }

//Not working
  static Future<void> createNewUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User account created successfully');
    } catch (e) {
      print('Failed to create user account: $e');
    }
  }

  static Future<Map<String, dynamic>> getTeacherById(String teacherId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('teachers')
            .doc(teacherId)
            .get();

    if (snapshot.exists) {
      return snapshot.data()!;
    } else {
      return {};
    }
  }
}
