import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getRecentlyCreatedStudents', () {
    test("Get 3 recently created students from 'students' collection",
        () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'students';

      await fakeFirestore
          .collection(collectionName)
          .add({'name': 'Layan', 'createdAt': Timestamp.now()});
      await fakeFirestore
          .collection(collectionName)
          .add({'name': 'John', 'createdAt': Timestamp.now()});
      await fakeFirestore
          .collection(collectionName)
          .add({'name': 'Alice', 'createdAt': Timestamp.now()});

      final result = await foo.getRecentlyCreatedStudents();

      expect(result.length, 3);

      expect(result[0]['name'], 'Alice');
      expect(result[1]['name'], 'John');
      expect(result[2]['name'], 'Layan');
    });
  });
}
