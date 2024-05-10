// ignore_for_file: unused_local_variable

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getAdmin', () {
    test("Get admin user from 'users' collection", () async {
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

      final result = await foo.getAdmin();

      expect(result, {'name': 'John', 'userType': 'Admin', 'id': docRef2.id});
    });
  });
}
