import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getAllData', () {
    test("Get all data from a collection", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'testCollection';

      final docRef1 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'Layan', 'age': 25});
      final docRef2 = await fakeFirestore
          .collection(collectionName)
          .add({'name': 'John', 'age': 30});

      final result = await foo.getAllData(collectionName);

      expect(result, [
        {'name': 'Layan', 'age': 25, 'id': docRef1.id},
        {'name': 'John', 'age': 30, 'id': docRef2.id},
      ]);
    });
  });
}
