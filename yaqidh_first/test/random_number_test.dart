import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() {
  group('generateRandomNumber', () {
    test("Generate a random number with length 5", () {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const length = 5;

      final result = foo.generateRandomNumber(length);

      expect(result.length, length);
      expect((result), isNotNull);
    });

    test("Generate a random number with length 10", () {
      final fakeFirestore = FakeFirebaseFirestore();
      final foo = RealFirestoreOperations(fakeFirestore);

      const length = 10;

      final result = foo.generateRandomNumber(length);

      expect(result.length, length);
      expect((result), isNotNull);
    });
  });
}
