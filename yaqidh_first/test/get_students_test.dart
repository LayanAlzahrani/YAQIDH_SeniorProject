import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getAllStudents', () {
    test("Get all students from 'students' collection", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'students';

      final docRef1 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'Layan', 'age': 25});
      final docRef2 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'John', 'age': 30});
      final docRef3 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'Alice', 'age': 20});

      final result = await foo.getAllStudents();

      expect(result, [
        {'name': 'Layan', 'age': 25, 'id': docRef1.id},
        {'name': 'John', 'age': 30, 'id': docRef2.id},
        {'name': 'Alice', 'age': 20, 'id': docRef3.id},
      ]);
    });
  });
}
