import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

import 'fire_store_mock.dart';

void main() async {
  setupCloudFirestoreMocks();
  RealFirestoreOperations? foo;
  setUpAll(() async {
    await Firebase.initializeApp();
    print("1111");
    await FirebaseFirestore.instance
        .collection('users')
        .doc("123")
        .set({"name": "Layan"});
    print("2222");
    foo = RealFirestoreOperations();
  });

  test("foo", () async {
    print(await foo!.getDocumentDataById("123", "users"));
  });
}
