import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<List<Map<String, dynamic>>> getAllStudents() async {
    return await getAllData('students');
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
}
