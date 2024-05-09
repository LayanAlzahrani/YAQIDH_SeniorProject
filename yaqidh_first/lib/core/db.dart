import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define an interface for Firestore operations
abstract class FirestoreOperations {
  Future<Map<String, dynamic>> getDocumentDataById(
    String docId,
    String collectionName,
  );

  Future<List<Map<String, dynamic>>> getAllData(String collectionName);

  Future<List<Map<String, dynamic>>> getAllTeachers();

  Future<Map<String, dynamic>?> getAdmin();

  Future<List<Map<String, dynamic>>> getAllStudents();

  Future<List<DocumentSnapshot>> getRecentlyCreatedStudents();

  Future<List<DocumentSnapshot>> getRecentlyCreatedTeachers();

  Future<List<Map<String, dynamic>>> getAllStudentsOfTeacher(String id);

  Future<void> deleteStudent(String studentId);

  Future<void> deleteTeacher(String teacherId);

  Future<Map<String, dynamic>> getTeacherById(String teacherId);

  String generateRandomNumber(int length);

  String generateRandomPassword();
}

// Real implementation of Firestore operations
class RealFirestoreOperations implements FirestoreOperations {
  late FirebaseFirestore instance;

  RealFirestoreOperations(this.instance);

  @override
  Future<Map<String, dynamic>> getDocumentDataById(
    String docId,
    String collectionName,
  ) async {
    var data = await instance.collection(collectionName).doc(docId).get();
    var map = data.data() as Map<String, dynamic>;
    return map;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllData(String collectionName) async {
    var snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();
    var data = snapshot.docs.map((e) {
      var docData = e.data();
      docData['id'] = e.id;
      return docData;
    }).toList();
    return data;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllTeachers() async {
    var data = await getAllData('users');
    return data
        .where((element) =>
            element['userType'].toString().toLowerCase() == 'teacher')
        .toList();
  }

  @override
  Future<Map<String, dynamic>?> getAdmin() async {
    var data = await getAllData('users');
    var admin = data.firstWhere(
        (element) => element['userType'].toString().toLowerCase() == 'admin');
    return admin;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    return await getAllData('students');
  }

  @override
  Future<List<DocumentSnapshot>> getRecentlyCreatedStudents() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return querySnapshot.docs;
  }

  @override
  Future<List<DocumentSnapshot>> getRecentlyCreatedTeachers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return querySnapshot.docs;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllStudentsOfTeacher(String id) async {
    var data = await getAllData('students');
    return data
        .where((student) => (student['teacher'] as DocumentReference).id == id)
        .toList();
  }

  @override
  Future<void> deleteStudent(String studentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .delete();
    } catch (error) {
      print('Error deleting student: $error');
    }
  }

  @override
  Future<void> deleteTeacher(String teacherId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(teacherId)
          .delete();
    } catch (error) {
      print('Error deleting student: $error');
    }
  }

  @override
  Future<Map<String, dynamic>> getTeacherById(String teacherId) async {
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

  @override
  String generateRandomNumber(int length) {
    Random random = Random();
    String number = '';

    for (int i = 0; i < length; i++) {
      number += random.nextInt(10).toString();
    }

    return number;
  }

  @override
  String generateRandomPassword() {
    Random random = Random();
    String uppercaseLetter = String.fromCharCode(random.nextInt(26) + 65);
    String numbersAndLetters = '0123456789abcdefghijklmnopqrstuvwxyz';
    String randomLetters = List.generate(7,
            (_) => numbersAndLetters[random.nextInt(numbersAndLetters.length)])
        .join('');
    return uppercaseLetter + randomLetters;
  }
}

// Proxy class for Firestore operations
class FirestoreOperationsProxy implements FirestoreOperations {
  final FirestoreOperations _realFirestoreOperations =
      RealFirestoreOperations(FirebaseFirestore.instance);

  @override
  Future<Map<String, dynamic>> getDocumentDataById(
      String docId, String collectionName) async {
    // TODO: implement getDocumentDataById
    return _realFirestoreOperations.getDocumentDataById(docId, collectionName);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllData(String collectionName) async {
    // TODO: implement getAllData
    return _realFirestoreOperations.getAllData(collectionName);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllTeachers() async {
    // TODO: implement getAllTeachers
    return _realFirestoreOperations.getAllTeachers();
  }

  @override
  Future<Map<String, dynamic>?> getAdmin() async {
    // TODO: implement getAdmin
    return _realFirestoreOperations.getAdmin();
  }

  @override
  Future<void> deleteStudent(String studentId) {
    // TODO: implement deleteStudent
    return _realFirestoreOperations.deleteStudent(studentId);
  }

  @override
  Future<void> deleteTeacher(String teacherId) {
    // TODO: implement deleteTeacher
    return _realFirestoreOperations.deleteTeacher(teacherId);
  }

  @override
  String generateRandomNumber(int length) {
    // TODO: implement generateRandomNumber
    return _realFirestoreOperations.generateRandomNumber(length);
  }

  @override
  String generateRandomPassword() {
    // TODO: implement generateRandomPassword
    return _realFirestoreOperations.generateRandomPassword();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllStudents() {
    // TODO: implement getAllStudents
    return _realFirestoreOperations.getAllStudents();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllStudentsOfTeacher(String id) {
    // TODO: implement getAllStudentsOfTeacher
    return _realFirestoreOperations.getAllStudentsOfTeacher(id);
  }

  @override
  Future<List<DocumentSnapshot<Object?>>> getRecentlyCreatedStudents() {
    // TODO: implement getRecentlyCreatedStudents
    return _realFirestoreOperations.getRecentlyCreatedStudents();
  }

  @override
  Future<List<DocumentSnapshot<Object?>>> getRecentlyCreatedTeachers() {
    // TODO: implement getRecentlyCreatedTeachers
    return _realFirestoreOperations.getRecentlyCreatedTeachers();
  }

  @override
  Future<Map<String, dynamic>> getTeacherById(String teacherId) {
    // TODO: implement getTeacherById
    return _realFirestoreOperations.getTeacherById(teacherId);
  }
}
