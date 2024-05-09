// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:yaqidh_first/Screens/Admin/addStudent.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:yaqidh_first/core/db.dart';

// class MockFirestore extends Mock implements FirebaseFirestore {}

// void main() {
//   group('Add Student', () {
//     // Test case 1: Adding student successfully
//     test('Add student to Firestore', () async {
//       final mockFirestore = MockFirestore();
//       final firestoreOperations = FirestoreOperationsProxy();
//       final selectedTeacher = {'id': 'teacherId', 'name': 'Teacher'};
//       final addStudentScreen = AddStudentScreen(
//         firestoreOperations: firestoreOperations,
//         selectedTeacher: selectedTeacher,
//       );

//       // Prepare test data
//       final studentData = {
//         'fullName': 'Layan',
//         'age': DateTime(2000, 1, 1),
//         'email': 'Layan@example.com',
//         'phone': '123456789',
//         'teacherId': 'teacherId',
//       };

//       // Act
//       await addStudentScreen.addStudentToFirestore(studentData);

//       // Assert
//       verify(mockFirestore.collection('students').doc(any).set(studentData))
//           .called(1);
//     });

//     // Test case 2: Handling error while adding student
//     test('Handle error while adding student', () async {
//       final mockFirestore = MockFirestore();
//       final firestoreOperations = FirestoreOperationsProxy();
//       final selectedTeacher = {'id': 'teacherId', 'name': 'Teacher'};
//       final addStudentScreen = AddStudentScreen(
//         firestoreOperations: firestoreOperations,
//         selectedTeacher: selectedTeacher,
//       );

//       // Prepare test data
//       final studentData = {
//         'fullName': 'Ftoon',
//         'age': DateTime(2000, 1, 1),
//         'email': 'Ftoon@example.com',
//         'phone': '123456789',
//         'teacherId': 'teacherId',
//       };

//       // Mock Firestore to throw an error
//       when(mockFirestore.collection('students').doc(any).set(studentData))
//           .thenThrow(Exception('Firestore error'));

//       // Act
//       final result = await addStudentScreen.addStudentToFirestore(studentData);

//       // Assert
//       expect(result, false);
//     });
//   });
// }
