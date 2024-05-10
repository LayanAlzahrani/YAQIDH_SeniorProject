// ignore_for_file: unused_local_variable

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getAllTeachers', () {
    test("Get all teachers from 'users' collection", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'users';

      final docRef1 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'Layan', 'userType': 'Teacher'});
      final docRef2 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'John', 'userType': 'Admin'});
      final docRef3 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'Alice', 'userType': 'Teacher'});

      final result = await foo.getAllTeachers();

      expect(result, [
        {'name': 'Layan', 'userType': 'Teacher', 'id': docRef1.id},
        {'name': 'Alice', 'userType': 'Teacher', 'id': docRef3.id},
      ]);
    });
  });
}
