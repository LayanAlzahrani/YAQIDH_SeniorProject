import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() async {
  final instance = FakeFirebaseFirestore();
  final foo = RealFirestoreOperations(instance);

  test("foo", () async {
    await instance.collection('users').doc("123").set({"name": "Layan"});
    var result = await foo.getDocumentDataById("123", "users");
    expect(result, {"name": "Layan"});
  });
}
