import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('getAllStudentsOfTeacher', () {
    test("Get all students of a teacher with ID 'teacher1'", () async {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const collectionName = 'students';
      const teacherOneId = '123456';
      const teacherTwoId = '789101';

      await fakeFirestore.collection(collectionName).add({
        'name': 'Student1',
        'teacher': fakeFirestore.doc('teachers/$teacherOneId')
      });
      await fakeFirestore.collection(collectionName).add({
        'name': 'Student2',
        'teacher': fakeFirestore.doc('teachers/$teacherOneId')
      });
      await fakeFirestore.collection(collectionName).add({
        'name': 'Student3',
        'teacher': fakeFirestore.doc('teachers/$teacherTwoId')
      });

      final result = await foo.getAllStudentsOfTeacher(teacherOneId);

      expect(result.length, 2);
      expect(result[0]['name'], 'Student1');
      expect(result[1]['name'], 'Student2');
    });
  });
}
