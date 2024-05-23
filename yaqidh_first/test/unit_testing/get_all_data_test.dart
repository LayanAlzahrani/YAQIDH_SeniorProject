import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getAllData', () {
    test("Get all data from a collection", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'students';

      final docRef1 =
          await fakeFirestore.collection(collectionName).add({'name': 'Layan'});
      final docRef2 =
          await fakeFirestore.collection(collectionName).add({'name': 'John'});

      final result = await foo.getAllData(collectionName);

      expect(result, [
        {'name': 'Layan', 'id': docRef1.id},
        {'name': 'John', 'id': docRef2.id},
      ]);
    });
  });
}
