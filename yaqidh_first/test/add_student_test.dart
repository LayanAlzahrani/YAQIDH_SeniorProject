import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaqidh_first/core/db.dart';

void main() async {
  final instance = FakeFirebaseFirestore();
  var code = RealFirestoreOperations(instance);

  test("addStudent", () async {
    final studentData = {
      'fullName': 'John Doe',
      'age': DateTime(2000, 1, 1).toString(),
      'email': 'john@example.com',
      'phone': '123456789',
      'isTested': false,
      'teacherId': '123456',
      'code': code.generateRandomNumber(6),
      'createdAt': FieldValue.serverTimestamp(),
      'dateOfTest': DateTime(2000, 1, 1).toString(),
      'teacher': 'Michel',
    };

    await instance.collection('students').doc('123').set(studentData);

    var studentDoc = await instance.collection('students').doc('123').get();

    expect(studentDoc.exists, true);

    // Check if the actual document contains all expected fields
    expect(studentDoc.data()?.keys, containsAll(studentData.keys));

    // Check the values
    expect(studentDoc.data()?['fullName'], equals(studentData['fullName']));
    expect(studentDoc.data()?['age'], equals(studentData['age']));
    expect(studentDoc.data()?['email'], equals(studentData['email']));
    expect(studentDoc.data()?['phone'], equals(studentData['phone']));
    expect(studentDoc.data()?['isTested'], equals(studentData['isTested']));
    expect(studentDoc.data()?['teacherId'], equals(studentData['teacherId']));
    expect(studentDoc.data()?['code'], equals(studentData['code']));
    expect(studentDoc.data()?['dateOfTest'], equals(studentData['dateOfTest']));
    expect(studentDoc.data()?['teacher'], equals(studentData['teacher']));

    // Convert the 'createdAt' to a DateTime object
    final expectedCreatedAtDateTime = DateTime.now();

    // Convert Timestamp to DateTime for comparison
    final actualCreatedAtTimestamp =
        (studentDoc.data()?['createdAt'] as Timestamp).toDate();

    // Calculate the difference in milliseconds
    final differenceInMilliseconds = actualCreatedAtTimestamp
        .difference(expectedCreatedAtDateTime)
        .inMilliseconds;

    expect(differenceInMilliseconds.abs(), lessThanOrEqualTo(100));
  });
}
