import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getRecentlyCreatedTeachers', () {
    test("Get 2 recently created teachers from 'users' collection", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'users';

      await fakeFirestore.collection(collectionName).add({
        'name': 'Layan',
        'createdAt': Timestamp.now(),
        'userType': 'Teacher'
      });
      await fakeFirestore.collection(collectionName).add({
        'name': 'John',
        'createdAt': Timestamp.now(),
        'userType': 'Teacher'
      });
      await fakeFirestore.collection(collectionName).add(
          {'name': 'Alice', 'createdAt': Timestamp.now(), 'userType': 'Admin'});

      final result = await foo.getRecentlyCreatedTeachers(filterUserType: true);

      expect(result.length, 2);
      expect(result[0]['name'], 'John');
      expect(result[1]['name'], 'Layan');
    });
  });
}
