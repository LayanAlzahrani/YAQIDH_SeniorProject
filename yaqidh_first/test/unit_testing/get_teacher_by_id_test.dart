import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getTeacherById', () {
    test("Get teacher by ID 'teacher1'", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'users';
      const teacherId = '123456';

      await fakeFirestore
          .collection(collectionName)
          .doc(teacherId)
          .set({'name': 'Teacher1', 'userType': 'teacher'});

      final result = await foo.getTeacherById(teacherId);

      expect(result['name'], 'Teacher1');
    });

    test("Get teacher by non-existing ID", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const teacherId = '234345';

      final result = await foo.getTeacherById(teacherId);

      expect(result, {});
    });
  });
}
